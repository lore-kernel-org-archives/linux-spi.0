From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: orion: Software control for inter-word delays
Date: Thu, 15 Feb 2018 16:45:55 +0100
Message-ID: <c5d27950-0d13-422c-afe9-990b4adad45a@cesnet.cz>
References: <bc8bf712358fbb000ea7e2ea9e1aec42b21988e6.1518704854.git.jan.kundrat@cesnet.cz>
 <475b63c52b17187089d3f2ecf8ff4b8c45a7e58b.1518704854.git.jan.kundrat@cesnet.cz>
 <20180215151907.GD8374@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>,
        Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>,
        Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>,
        Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180215151907.GD8374-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On =C4=8Dtvrtek 15. =C3=BAnora 2018 16:19:07 CET, Mark Brown wrote:
> I think this is a sensible and reasonable thing to want to do however I
> think we should move this from a DT property to being something in the
> transfer structure which drivers then implement.  That way if a device
> has an inter-word delay requirement it can go in the individual device
> driver so it always gets applied.  Does that make sense to you?

Yep, that indeed makes sense (Damn, my easy attempt didn't make it :).)

How should the interface look like? Is spi_controller->mode_bits a good=20
place for controllers to advertise this feature (SPI_WORD_DELAY, perhaps?)=20=

as supported, with spi-orion being the only implementation now? If we allow=20=

each spi_transfer to override this value, is there a common place in the=20
SPI core which somehow validates a spi_transfer against each controller's=20
capabilities? I see a code like that (bad_bits, ugly_bits) in spi_setup=20
which looks like something to be called per-device, not per-transfer.

My most important use case is, however, the userspace-facing spidev, and=20
its ioctl complicates stuff a bit. The relevant struct has a 16bit padding=20=

now (used to be 32bit prior to=20
https://patchwork.kernel.org/patch/3715391/). Is it OK to use this padding=20=

for this feature? Or should I perhaps eat just 8bits and limit the delays=20
to an arbitrary value of 255us? Or should I not care about that now and let=20=

somebody else come up with another "bigger" ioctl when they need that=20
space?

With kind regards,
Jan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
