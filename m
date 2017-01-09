From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH] SPI: make falcon-spi bool
Date: Tue, 10 Jan 2017 00:32:22 +0100
Message-ID: <863bd068-8938-9d2e-4036-6f53318a7b4a@hauke-m.de>
References: <20170103170427.26120-1-hauke@hauke-m.de>
 <20170104104624.z4ijsadskpmd26p5@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170104104624.z4ijsadskpmd26p5-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 01/04/2017 11:46 AM, Mark Brown wrote:
> On Tue, Jan 03, 2017 at 06:04:27PM +0100, Hauke Mehrtens wrote:
>> Falcon spi accesses some ebu functions which are not exported and can
>> not be accessed when build as module. Make this module bool instead.
> 
> Why is the fix here not to export these functions (or longer term to fix
> things so that we're not going through custom APIs)?

This should only be the short term fix for this problem and for long
term I want to fix the arch code for lantiq. This drivers accesses the
ltq_ebu_membase memory area and I do not want to export that.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
