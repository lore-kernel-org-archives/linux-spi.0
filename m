From: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: M25P80 Regulator Question
Date: Fri, 1 Nov 2013 14:05:08 -0400
Message-ID: <5273ED54.5030101@nvidia.com>
References: <5273E881.8080401@nvidia.com> <20131101180243.GY2493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131101180243.GY2493-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 11/1/2013 2:02 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Nov 01, 2013 at 01:44:33PM -0400, Rhyland Klein wrote:
> 
>> Is there some mechanism for defining this dependency?
> 
> Same as any other device, add the regulator to the binding for the flash
> chip and add the appropriate code to the chip.
> 
> * Unknown Key
> * 0x7EA229BD
> 

Thanks,

I just wanted to make sure I wasn't missing anything. I'll come up with
some patches. I believe there are patches in for optional regulator
support right, so I assume that would be the most logical path to take?

-rhyland

-- 
nvpublic
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
