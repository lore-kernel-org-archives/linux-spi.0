From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 02/23] spi: fsl-espi: remove unused elements n_rx and
 n_tx in struct fsl_espi_transfer
Date: Sun, 4 Sep 2016 00:15:34 +0200
Message-ID: <452347f8-3727-6f39-5398-dded6cdb45e4@gmail.com>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
 <52c5893a-5927-4c83-4838-d618d434922c@gmail.com>
 <20160903000910.GP3950@sirena.org.uk>
 <226e54e5-98d9-75a7-5cfc-3f21492cd358@gmail.com>
 <20160903215954.GU3950@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160903215954.GU3950-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 03.09.2016 um 23:59 schrieb Mark Brown:
> On Sat, Sep 03, 2016 at 11:04:29PM +0200, Heiner Kallweit wrote:
>> Am 03.09.2016 um 02:09 schrieb Mark Brown:
> 
>>> I'm missing a lot of patches from this series, at least the first one
>>> but there's a bunch of others too.  Please check and resend.
> 
>> Patches 1 and 4-7 of the series you applied already. Yesterday I sent
>> a v2 of patches 2, 3 and about an hour later v2 of patches 8-23.
> 
> Patch numbering exists solely in order to sort the patches within the
> series you're sending.  If you've previously sent patches that's totally
> irrelevant and confuses things, just number the patches in order without
> gaps.
> 
OK, so I'll resend the remaining 18 patches of the series with new numbering.

>> Based on your review comments it's mainly about reordering patches
>> (do trivial things first), smaller code style fixes, and mainly rebasing.
>> Maybe some issue with referencing the mails correctly?
> 
> Not sure what you mean here but if you're trying to send the patches in
> reply to their versions in the earlier series that also confuses things.
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
