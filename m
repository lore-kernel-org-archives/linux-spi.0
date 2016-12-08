From: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] mtd: spi-nor: add a stateless method to support
 memory size above 128Mib
Date: Thu, 8 Dec 2016 04:50:58 +0100
Message-ID: <ff272ee1-0e0c-137d-eb76-6005d04a10aa@gmail.com>
References: <cover.1481041702.git.cyrille.pitchen@atmel.com>
 <97e02fd9d6328bc591f98d5ae3da98b0ad9051d2.1481041702.git.cyrille.pitchen@atmel.com>
 <e1f9652e-4dda-0420-69d3-6fef606bc5dd@gmail.com>
 <6623dc41-f7a8-9788-fe01-7fe3d5b2062f@atmel.com>
 <6443cfb4-2d6d-c929-0d8a-053082bda506@gmail.com>
 <679d301c-363a-e8fe-abed-c3ad00ea1fad@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
        richard-/L3Ra7n9ekc@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <679d301c-363a-e8fe-abed-c3ad00ea1fad-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 12/07/2016 05:59 PM, Cyrille Pitchen wrote:
> Le 07/12/2016 à 17:32, Marek Vasut a écrit :
>> On 12/07/2016 05:29 PM, Cyrille Pitchen wrote:
>>> Le 07/12/2016 à 17:20, Marek Vasut a écrit :
>>>> On 12/06/2016 05:52 PM, Cyrille Pitchen wrote:
>>>>> This patch provides an alternative mean to support memory above 16MiB
>>>>> (128Mib) by replacing 3byte address op codes by their associated 4byte
>>>>> address versions.
>>>>>
>>>>> Using the dedicated 4byte address op codes doesn't change the internal
>>>>> state of the SPI NOR memory as opposed to using other means such as
>>>>> updating a Base Address Register (BAR) and sending command to enter/leave
>>>>> the 4byte mode.
>>>>>
>>>>> Hence when a CPU reset occurs, early bootloaders don't need to be aware
>>>>> of BAR value or 4byte mode being enabled: they can still access the first
>>>>> 16MiB of the SPI NOR memory using the regular 3byte address op codes.
>>>>>
>>>>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>>>>> Tested-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
>>>>> ---
>>>>>  drivers/mtd/spi-nor/spi-nor.c | 114 ++++++++++++++++++++++++++++++++++--------
>>>>>  1 file changed, 93 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>>>>> index 8abe134e174a..606c030c566d 100644
>>>>> --- a/drivers/mtd/spi-nor/spi-nor.c
>>>>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>>>>> @@ -75,6 +75,10 @@ struct flash_info {
>>>>>  					 * bit. Must be used with
>>>>>  					 * SPI_NOR_HAS_LOCK.
>>>>>  					 */
>>>>> +#define SPI_NOR_4B_OPCODES	BIT(10)	/*
>>>>> +					 * Use dedicated 4byte address op codes
>>>>> +					 * to support memory size above 128Mib.
>>>>> +					 */
>>>>>  };
>>>>>  
>>>>>  #define JEDEC_MFR(info)	((info)->id[0])
>>>>> @@ -188,6 +192,91 @@ static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
>>>>>  	return mtd->priv;
>>>>>  }
>>>>>  
>>>>> +
>>>>> +struct spi_nor_address_entry {
>>>>> +	u8	src_opcode;
>>>>> +	u8	dst_opcode;
>>>>> +};
>>>>> +
>>>>> +static u8 spi_nor_convert_opcode(u8 opcode,
>>>>> +				 const struct spi_nor_address_entry *entries,
>>>>> +				 size_t num_entries)
>>>>> +{
>>>>> +	int min, max;
>>>>> +
>>>>> +	/*
>>>>> +	 * This function implements a dichotomic search in the entries[]
>>>>> +	 * array indexed by src_opcode. Hence we assume that the entries[]
>>>>> +	 * array is sorted by src_opcode.
>>>>> +	 * The dichotomic search has a logarithmic complexity as opposed
>>>>> +	 * to a simple loop on all entires, which has a linear complexity:
>>>>> +	 * it means that when n is the number of entries in the input array,
>>>>> +	 * the dichotomic search performs O(log2(n)) comparisons whereas
>>>>> +	 * a simple loop performs O(n) comparisons.
>>>>> +	 */
>>>>> +	min = 0;
>>>>> +	max = num_entries - 1;
>>>>> +	while (min <= max) {
>>>>> +		int mid = (min + max) >> 1;
>>>>> +		const struct spi_nor_address_entry *entry = &entries[mid];
>>>>> +
>>>>> +		if (opcode == entry->src_opcode)
>>>>> +			return entry->dst_opcode;
>>>>> +
>>>>> +		if (opcode < entry->src_opcode)
>>>>> +			max = mid - 1;
>>>>> +		else
>>>>> +			min = mid + 1;
>>>>> +	}
>>>>
>>>> You have like 16 entries in that table, just do a linear search, this is
>>>> only complex for no benefit.
>>>
>>> Well ok, I agree with you, it's too much overkill for what it does.
>>> For readiness purpose, what about a simple and straight forward switch()
>>> statement? Let's forget about cache-line and other memory/time optimizations :)
>>
>> If you do a switch, you cannot walk a table which you pass in, see below.
>>
> 
> I meant I remove the table too, a hidden "table" would still be generated
> by the compiler in the assembly code to translate the switch statement:
> 
> static u8 spi_nor_3to4_opcode(u8 3byte_address_opcode)
> {
> 	#define CASE_3TO4(_opcode)	case _opcode: return _opcode##_4B
> 	
> 	switch (3_byte_address_opcode) {
> 	/* Without macro. */
> 	case SPINOR_OP_PP:
> 		return SPINOR_OP_PP_4B;
> 
> 	case SPINOR_OP_READ:
> 		return SPINOR_OP_READ_4B;
> 
> 	case SPINOR_OP_READ_FAST:
> 		return SPINOR_OP_READ_FAST_4B;
> 
> 	/* With macro. */
> 	CASE_3TO4(SPINOR_OP_READ_FAST);

Geh, the macro stuff is something I don't really like, it feels like
it's obfuscating the code for little benefit. But that might be a matter
of my personal taste.

> 	default:
> 		break;
> 	}
> 
> 	/* No conversion found */
> 	return opcode;
> }
> 
> For readiness, I don't whether people prefer the version with macro or the
> version without. Just tell me :)

Well, you asked for it ... I demand that you implement it with a table! ;-)

I can see something like:

static const u8 spi_read_opcodes[][2] = {
 { SPINOR_OP_READ,      SPINOR_OP_READ_4B },
 { SPINOR_OP_READ_FAST, SPINOR_OP_READ_4B_FAST },
}
...
u8 convert_opcode(u8 opcodes[][2], opcodesize) {

for (i = 0; i < opcodesize; i++)
    if (opcodes[i][0] == opcode)
        return opcodes[i][1];

return opcode;
}

It feels a bit more compact and explicit, but it might be just my taste.

> Of course with the switch statement I no longer need the struct
> spi_nor_address_entry.
> 
> Also for now I don't need a 4TO3 translation.
> 
> 
>>>>> +	/* No conversion found */
>>>>> +	return opcode;
>>>>> +}
>>>>> +
>>>>> +static u8 spi_nor_3to4_opcode(u8 opcode)
>>>>> +{
>>>>> +	/* MUST be sorted by 3byte opcode (cf spi_nor_convert_opcode). */
>>>>> +#define ENTRY_3TO4(_opcode)	{ _opcode, _opcode##_4B }
>>>>> +	static const struct spi_nor_address_entry spi_nor_3to4_table[] = {
>>>>
>>>> You can make this static const struct const for extra constness :-)
>>>>
>>>>> +		ENTRY_3TO4(SPINOR_OP_PP),		/* 0x02 */
>>>>> +		ENTRY_3TO4(SPINOR_OP_READ),		/* 0x03 */
>>>>> +		ENTRY_3TO4(SPINOR_OP_READ_FAST),	/* 0x0b */
>>>>> +		ENTRY_3TO4(SPINOR_OP_BE_4K),		/* 0x20 */
>>>>> +		ENTRY_3TO4(SPINOR_OP_PP_1_1_4),		/* 0x32 */
>>>>> +		ENTRY_3TO4(SPINOR_OP_PP_1_4_4),		/* 0x38 */
>>>>> +		ENTRY_3TO4(SPINOR_OP_READ_1_1_2),	/* 0x3b */
>>>>> +		ENTRY_3TO4(SPINOR_OP_BE_32K),		/* 0x52 */
>>>>> +		ENTRY_3TO4(SPINOR_OP_READ_1_1_4),	/* 0x6b */
>>>>> +		ENTRY_3TO4(SPINOR_OP_READ_1_2_2),	/* 0xbb */
>>>>> +		ENTRY_3TO4(SPINOR_OP_SE),		/* 0xd8 */
>>>>> +		ENTRY_3TO4(SPINOR_OP_READ_1_4_4),	/* 0xeb */
>>>>
>>>> I'd probably break this into three smaller tables, read/program/erase
>>>> and then call something like:
>>>>
>>>> spi_nor_3to4_opcode(nor->read_opcode, read_opcode_table,
>>>>                     ARRAY_SIZE(read_opcode_table));
>>>>
>>>> This would further reduce the table size (heck, it'd probably fit into a
>>>> cacheline), so linear search would be more than enough.
>>>>
>>>>> +	};
>>>>> +#undef ENTRY_3TO4
>>>>> +
>>>>> +	return spi_nor_convert_opcode(opcode, spi_nor_3to4_table,
>>>>> +				      ARRAY_SIZE(spi_nor_3to4_table));
>>>>> +}
>>>>> +
>>>>> +static void spi_nor_set_4byte_opcodes(struct spi_nor *nor,
>>>>> +				      const struct flash_info *info)
>>>>> +{
>>>>> +	/* Do some manufacturer fixups first */
>>>>> +	switch (JEDEC_MFR(info)) {
>>>>> +	case SNOR_MFR_SPANSION:
>>>>> +		/* No small sector erase for 4-byte command set */
>>>>> +		nor->erase_opcode = SPINOR_OP_SE;
>>>>> +		nor->mtd.erasesize = info->sector_size;
>>>>> +		break;
>>>>> +
>>>>> +	default:
>>>>> +		break;
>>>>> +	}
>>>>> +
>>>>> +	nor->read_opcode	= spi_nor_3to4_opcode(nor->read_opcode);
>>>>> +	nor->program_opcode	= spi_nor_3to4_opcode(nor->program_opcode);
>>>>> +	nor->erase_opcode	= spi_nor_3to4_opcode(nor->erase_opcode);
>>>>> +}
>>>>> +
>>>>>  /* Enable/disable 4-byte addressing mode. */
>>>>>  static inline int set_4byte(struct spi_nor *nor, const struct flash_info *info,
>>>>>  			    int enable)
>>>>> @@ -1486,27 +1575,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>>>>>  	else if (mtd->size > 0x1000000) {
>>>>>  		/* enable 4-byte addressing if the device exceeds 16MiB */
>>>>>  		nor->addr_width = 4;
>>>>> -		if (JEDEC_MFR(info) == SNOR_MFR_SPANSION) {
>>>>> -			/* Dedicated 4-byte command set */
>>>>> -			switch (nor->flash_read) {
>>>>> -			case SPI_NOR_QUAD:
>>>>> -				nor->read_opcode = SPINOR_OP_READ_1_1_4_4B;
>>>>> -				break;
>>>>> -			case SPI_NOR_DUAL:
>>>>> -				nor->read_opcode = SPINOR_OP_READ_1_1_2_4B;
>>>>> -				break;
>>>>> -			case SPI_NOR_FAST:
>>>>> -				nor->read_opcode = SPINOR_OP_READ_FAST_4B;
>>>>> -				break;
>>>>> -			case SPI_NOR_NORMAL:
>>>>> -				nor->read_opcode = SPINOR_OP_READ_4B;
>>>>> -				break;
>>>>> -			}
>>>>> -			nor->program_opcode = SPINOR_OP_PP_4B;
>>>>> -			/* No small sector erase for 4-byte command set */
>>>>> -			nor->erase_opcode = SPINOR_OP_SE_4B;
>>>>> -			mtd->erasesize = info->sector_size;
>>>>> -		} else
>>>>> +		if (JEDEC_MFR(info) == SNOR_MFR_SPANSION ||
>>>>> +		    info->flags & SPI_NOR_4B_OPCODES)
>>>>> +			spi_nor_set_4byte_opcodes(nor, info);
>>>>> +		else
>>>>>  			set_4byte(nor, info, 1);
>>>>>  	} else {
>>>>>  		nor->addr_width = 3;
>>>>>
>>>>
>>>>
>>>
>>
>>
> 


-- 
Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
