From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH, V4, 2/5] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Tue, 12 Jul 2016 18:06:04 -0400
Message-ID: <CAC=U0a3WN9TGw7zwwP3qFf5MUsRteUcVLytFgjnP4zScZS0xXA@mail.gmail.com>
References: <1466197433-11290-1-git-send-email-kdasu.kdev@gmail.com>
 <1466197433-11290-2-git-send-email-kdasu.kdev@gmail.com> <20160622160726.GQ28202@sirena.org.uk>
 <CAKekbevYN3CLvqQs3stUXDFEMREMOJ0g4+w7Zsno1kV-ieYEiw@mail.gmail.com> <20160701160753.GX6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list"
	<bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160701160753.GX6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Mark,

On Fri, Jul 1, 2016 at 12:07 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Jul 01, 2016 at 11:39:03AM -0400, Kamal Dasu wrote:
>
>> > All this interrupt code and especially the fact that it's a completely
>> > separate register range in the binding looks very much like it's just
>> > an interrupt controller IP that's not particularly anything to do with
>> > the SPI controller and should therefore be in a separate driver.  Why is
>> > this part of the SPI controller driver?
>
>> Some SoCs need this since they do not implement a separate interrupt
>> controller and have dedicated l1 interrupt for spi. Also the handling
>> is not generic enough to cover other ips as well in those case. Hence
>> have to handle it within the driver.
>
> That doesn't seem to match what the code is actually doing.  The
> register block this is controlling is separate to the rest of the IP.
> It's perfectly OK to have a driver for an interrupt controller which is
> only used in one place, though you may find one of the generic ones
> might be able to handle it anyway.
>

The NS* SoC  SPI blocks has hw glue logic specific to MSPI+BSPI, so
the re-usability of an interrupt controller driver for this  logic is
limited.  The spi only (spi protocol) block does use l2 controller,
however for the MSPI+BSPI block used for the spi-nor flash had to
introduce the code to handle l1 interrupts within the code itself. In
this case can the driver be accepted without having to introduce a new
intc driver ?.

Thanks
Kamal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
