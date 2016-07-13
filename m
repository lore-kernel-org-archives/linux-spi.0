From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH, V4, 2/5] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Wed, 13 Jul 2016 14:34:57 -0700
Message-ID: <5786B401.2050306@gmail.com>
References: <1466197433-11290-1-git-send-email-kdasu.kdev@gmail.com>
 <1466197433-11290-2-git-send-email-kdasu.kdev@gmail.com>
 <20160622160726.GQ28202@sirena.org.uk>
 <CAKekbevYN3CLvqQs3stUXDFEMREMOJ0g4+w7Zsno1kV-ieYEiw@mail.gmail.com>
 <20160701160753.GX6247@sirena.org.uk>
 <CAC=U0a3WN9TGw7zwwP3qFf5MUsRteUcVLytFgjnP4zScZS0xXA@mail.gmail.com>
 <20160713111053.GG9976@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160713111053.GG9976-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 07/13/2016 04:10 AM, Mark Brown wrote:
> On Tue, Jul 12, 2016 at 06:06:04PM -0400, Kamal Dasu wrote:
> 
>> The NS* SoC  SPI blocks has hw glue logic specific to MSPI+BSPI, so
>> the re-usability of an interrupt controller driver for this  logic is
>> limited.  The spi only (spi protocol) block does use l2 controller,
>> however for the MSPI+BSPI block used for the spi-nor flash had to
>> introduce the code to handle l1 interrupts within the code itself. In
>> this case can the driver be accepted without having to introduce a new
>> intc driver ?.
> 
> It's not really about reuse, it's about maintainability.  All the code
> for handling this within the driver is quite unusual and makes the
> driver harder to understand and review.  That's going to have an impact
> now and make things harder to follow in future too.  Fitting in with the
> frameworks means that we get the benefit of the structure and support
> code that the frameworks provide while minimizing the amount of unusal
> code in the driver.

This is not unusual at all, there are tons of peripherals that embed a
L2/L3 interrupt controller, yet keep the code localized because the
interrupt sources are not visible outside of the specific block and it
would not make sense to demultiplex these different interrupt sources as
individually requestable interrupt lines when the consumer is also local
and self contained.

This is exactly what is going on here, and it this makes the driver more
self contained without external dependencies to an irqchip driver to an
interrupt controller provider.

The reusability argument is kind of the only one that makes sense here,
maintaining two drivers instead of one seems like more maintenance
burden imho.
-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
