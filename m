From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH, V4, 1/5] Documentation: dt: spi-bcm-qspi: NSP, NS2,
 BRCMSTB SoC bindings
Date: Wed, 22 Jun 2016 10:10:55 -0700
Message-ID: <576AC69F.6080507@gmail.com>
References: <1466197433-11290-1-git-send-email-kdasu.kdev@gmail.com>
 <20160622145141.GN28202@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160622145141.GN28202-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 06/22/2016 07:51 AM, Mark Brown wrote:
> On Fri, Jun 17, 2016 at 05:03:49PM -0400, Kamal Dasu wrote:
>> Added device tree bindings documentation for SoCs supported by the
>> new spi-bcm-qspi driver.
> 
> To repeat what I said on your previous version:
> 
> | So this is a perfect example of why you should use standard formats for
> | subject lines, if things don't look relevant they're likely to get
> | missed.  In this case it's both the prefix and the fact that the version
> | is added in a weird way.  Frankly I didn't even notice that it wasn't a
> | cover letter.
> 
> Please don't ignore review comments, people are generally making them
> for a reason and are likely to have the same concerns if issues remain
> unaddressed.
> 
>> +- compatible:
>> +    Must be one of :
>> +    "brcm,spi-bcm-qspi"
>> +    "brcm,spi-brmstb" spi-nor and/or "brcm,spi-brmstb-mspi" unmanaged SPI Master
> 
> What do these compatible strings mean, what are the differences between
> them?  The last two sound like configuration of a single IP rather than
> descriptions of hardware.

The Broadcom STB SoCs have two instances of this SPI HW block, one which
is MSPI+BSPI capable and another one which is MSPI only (or that's how
we call them), the difference in the compatible strings tries to denote
and capture that.
-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
