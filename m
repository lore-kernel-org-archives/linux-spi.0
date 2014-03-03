From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-dspi: Fix getting correct address for master
Date: Mon, 3 Mar 2014 16:42:19 +0800
Message-ID: <CAFRkauC7z4UepyK-oH861OEo62+4b82idWPAkK99vmY0=T3w9A@mail.gmail.com>
References: <1392353352.19487.1.camel@phoenix>
	<CAFRkauD3WFBw9VC6h+2bxcnuky7175G47+7tP8=5f4D2PeLpEQ@mail.gmail.com>
	<20140303014608.GL2411@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140303014608.GL2411-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-03-03 9:46 GMT+08:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Sun, Mar 02, 2014 at 11:09:41PM +0800, Axel Lin wrote:
>> 2014-02-14 12:49 GMT+08:00 Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>:
>> > Current code set platform drvdata to dspi. However, the code in dspi_suspend()
>> > and dspi_resume() assumes the drvdata is the address of master.
>> > Fix it by setting platform drvdata to master.
>
>> Hi Mark,
>> I guess this one is for 3.14.
>
>> In dspi_probe(),
>> current code has:
>>         platform_set_drvdata(pdev, dspi);
>
>> However, in dspi_suspend() and dspi_resume(),
>> current code has:
>>         struct spi_master *master = dev_get_drvdata(dev);
>
> The patch doesn't seem to have been appleid at all?

Ah, right , this one is not yet in your tree.

And I think a similar patch for coldfire-qspi needs for 3.14 to make
runtime suspend/resume work.

commit  80467f761b01a2df5284661e9bf9876eee6a9573
spi: coldfire-qspi: Fix getting correct address for *mcfqspi

dev_get_drvdata() returns the address of master rather than mcfqspi.

Regards,
Axel
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
