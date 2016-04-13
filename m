From: Lakshmi Sai Krishna Potthuri
	<lakshmi.sai.krishna.potthuri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [LINUX PATCH v2 1/3] spi: Added dummy_cycle entry in the
 spi_transfer structure.
Date: Wed, 13 Apr 2016 05:21:25 +0000
Message-ID: <4FF8F58FAA9D5D4193D4E554E4352C5902C720DE@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1460039969-9835-1-git-send-email-lakshmis@xilinx.com>
 <57067694.8030806@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Anirudha Sarangi <anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"R, Vignesh" <vigneshr-l0cyMroinI0@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	"Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	Jagan Teki <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>,
	=?iso-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57067694.8030806-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Cyrille and Mark,

>-----Original Message-----
>From: Cyrille Pitchen [mailto:cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org]
>Sent: Thursday, April 07, 2016 8:33 PM
>To: Lakshmi Sai Krishna Potthuri <lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>; Michal Simek
><michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>; Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>; David
>Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>; Brian Norris
><computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>;
>Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>; Boris Brezillon
><boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>; Stephen Warren
><swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>;
>Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>; Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>; Jagan Teki
><jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>; Rafa=B3 Mi=B3ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux=
-
>spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Harini Kata=
kam
><harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>; Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>;
>Anirudha Sarangi <anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>; Lakshmi Sai Krishna Potthuri
><lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>; R, Vignesh <vigneshr-l0cyMroinI0@public.gmane.org>
>Subject: Re: [LINUX PATCH v2 1/3] spi: Added dummy_cycle entry in the
>spi_transfer structure.
>
>Hi all,
>
>Le 07/04/2016 16:39, P L Sai Krishna a =E9crit :
>> This patch adds dummy_cycles entry in the spi_transfer structure.
>> len field in the transfer structure contains dummy bytes along with
>> actual data bytes, controllers which requires dummy bytes use len
>> field and simply Ignore the dummy_cycles field. Controllers which
>> expects dummy cycles won't work directly by using len field because
>> host driver doesn't know that len field of a particular transfer
>> includes dummy bytes or not (and also number of dummy bytes included
>> in len field). In such cases host driver use this dummy_cycles field
>> to identify the number of dummy cycles and based on that it will sen=
d
>> the required number of dummy cycles.
>
>Dummy cycles are only used with SPI NOR flashes, aren't they?

Yes, with SPI NOR flashes.

>I guess so since there is also a patch dedicated to the m25p80 driver.
>
>So why not using the spi_flash_read() API already introduced by Vignes=
h
>in the SPI layer?

ZynqMP GQSPI controller driver use "transfer_one" hook. Since this is g=
eneric
Controller majorly interfaced to flash devices and it might extend to N=
AND
flashes in future. This patch does not disturb the existing implementat=
ion of
accessing the flash or other slave devices. It adds an additional optio=
nal
feature. So there is no harm to controllers that don't need dummy cycle=
s -
they can ignore it and still work with the existing implementation.

Regards
Sai Krishna
>
>struct spi_flash_read_message already includes a 'dummy_bytes' member.
>
>>
>> Signed-off-by: P L Sai Krishna <lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
>> ---
>> v2:
>>  - Changed the structure member name from dummy to dummy_cycles.
>>  - Updated the documentation of dummy_cycles.
>>  - m25p80 changes split into another patch.
>>
>>  include/linux/spi/spi.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
>> index 857a9a1..63135b3 100644
>> --- a/include/linux/spi/spi.h
>> +++ b/include/linux/spi/spi.h
>> @@ -664,6 +664,9 @@ extern void spi_res_release(struct spi_master
>*master,
>>   * @len: size of rx and tx buffers (in bytes)
>>   * @speed_hz: Select a speed other than the device default for this
>>   *      transfer. If 0 the default (from @spi_device) is used.
>> + * @dummy_cycles: number of dummy cycles. If host controller requir=
es
>> + *  dummy cycles rather than dummy bytes which send along with Cmd
>> + *  and address then this dummy_cycles is used.
>>   * @bits_per_word: select a bits_per_word other than the device def=
ault
>>   *      for this transfer. If 0 the default (from @spi_device) is u=
sed.
>>   * @cs_change: affects chipselect after this transfer completes
>> @@ -752,6 +755,7 @@ struct spi_transfer {
>>      u8              bits_per_word;
>>      u16             delay_usecs;
>>      u32             speed_hz;
>> +    u32             dummy_cycles;
>>
>>      struct list_head transfer_list;
>>  };
>>
>
>Best regards,
>
>Cyrille


This email and any attachments are intended for the sole use of the nam=
ed recipient(s) and contain(s) confidential information that may be pro=
prietary, privileged or copyrighted under applicable law. If you are no=
t the intended recipient, do not read, copy, or forward this email mess=
age or any attachments. Delete this email message and any attachments i=
mmediately.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
