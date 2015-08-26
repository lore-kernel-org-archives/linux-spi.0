From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: fsl-(e)spi: simplify cleanup code
Date: Wed, 26 Aug 2015 19:56:45 +0200
Message-ID: <55DDFDDD.8050508@gmail.com>
References: <55D9BAE1.1030306@gmail.com> <20150825174508.GF12878@sirena.org.uk> <55DCCDD7.5030307@gmail.com> <20150826105857.GQ12878@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150826105857.GQ12878-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 26.08.2015 um 12:58 schrieb Mark Brown:
> On Tue, Aug 25, 2015 at 10:19:35PM +0200, Heiner Kallweit wrote:
>> Am 25.08.2015 um 19:45 schrieb Mark Brown:
> 
>>> You should be able to remove empty functions like this one.
> 
>> In patch 3 a call to pm_runtime_disable is added to this function.
>> Therefore I don't remove it in patch 2. Fine with you?
> 
> No, just re-add it when you add users.
> 
OK, I will consider this when sending v2 of the patch series.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
