From: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: M25P80 Regulator Question
Date: Fri, 1 Nov 2013 14:17:17 -0400
Message-ID: <5273F02D.5000707@nvidia.com>
References: <5273E881.8080401@nvidia.com> <20131101180243.GY2493@sirena.org.uk> <5273ED54.5030101@nvidia.com> <20131101181628.GD2493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131101181628.GD2493-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 11/1/2013 2:16 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Nov 01, 2013 at 02:05:08PM -0400, Rhyland Klein wrote:
> 
>> I just wanted to make sure I wasn't missing anything. I'll come up with
>> some patches. I believe there are patches in for optional regulator
>> support right, so I assume that would be the most logical path to take?
> 
> No, you should not be using regulator_get_optional() - it is unlikely
> that the flash device will work without power.
> 
> * Unknown Key
> * 0x7EA229BD
> 
Alright, thanks!!


-- 
nvpublic
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
