From: Lakshmi Sai Krishna Potthuri
	<lakshmi.sai.krishna.potthuri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [LINUX PATCH 1/2] mtd: Added dummy entry in the spi_transfer
 structure.
Date: Tue, 22 Mar 2016 06:39:51 +0000
Message-ID: <4FF8F58FAA9D5D4193D4E554E4352C5902C6D34C@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1458562809-36114-1-git-send-email-lakshmis@xilinx.com>
 <20160321130734.GS2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	"Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	Jagan Teki <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>,
	=?iso-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Anirudha Sarangi <anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160321130734.GS2566-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

<snip>
>On Mon, Mar 21, 2016 at 05:50:08PM +0530, P L Sai Krishna wrote:
>> This patch does following things.
>> 1. Added dummy entry in the spi_transfer structure.
>> 2. Assigned dummy cycles to dummy member in the transfer structure
>> during read operation.
>
>Please try to follow the patch submission process covered in
>SubmittingPatches, in particular please use subject lines reflecting the style
>for the subsystem (which helps people identify relevant changes to
>review) and...
>
>>  drivers/mtd/devices/m25p80.c | 1 +
>>  include/linux/spi/spi.h      | 2 ++
>>  2 files changed, 3 insertions(+)
>
>...split things up into individual patches, for example here you're both adding a
>new feature and adding a user of that feature in a single patch.

I will split the patch into two with appropriate commit messages.

>
>> + * @dummy: number of dummy cycles.
>
>This needs to be clearer about what a dummy cycle is and where it gets
>inserted.  We probably also want a better name, just "dummy" makes it look
>like a padding field in the structure.  How about dummy_cycles?

dummy_cycles is a better idea.
I will change it and add the usage of this in the description in a detailed manner.

>
>> @@ -752,6 +753,7 @@ struct spi_transfer {
>>      u8              bits_per_word;
>>      u16             delay_usecs;
>>      u32             speed_hz;
>> +    u32             dummy;
>>
>>      struct list_head transfer_list;
>>  };
>
>This isn't enough to add the feature - a client driver trying to make use of this
>needs to be able to tell if the cycles are actually going to be inserted.  I'd
>expect to see a capability flag that can be checked and some error checking so
>that if we try to do a transfer with dummy cycles and can't support it we don't
>silently ignore the dummy cycles, ideally also something that'll handle
>multiples of 8 bits with SPI controllers that don't otherwise support this
>feature.

Currently, all fast reads use 8 cycles or 1 byte of dummy. This generally works.
But it can be vary based on the flash and the type of read command.
Dummy bytes are taken care of in m25p80.c by adjusting the len field:
Length = size of (command + address + dummy byte)

There might be controllers (like ZynqMP GQSPI) that would be able to use
the information that dummy byte(s) were added and the precise number
of dummy cycles. This patch does not disturb the existing implementation
of adjusting length (as described above). It adds an additional optional feature.
So there is no harm to controllers that can't support it - they can ignore it and
still work with the existing "length adjustment" implementation.
If you think there value in adding a capability flag, please let me know.

Thanks for your review.

Regards,
Sai Krishna


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
