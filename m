From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: expose spi_master and spi_device statistics via sysfs
Date: Sat, 20 Jun 2015 17:24:56 +0200
Message-ID: <D2E5B422-6D11-472D-9458-EDF2AEFD891D@martin.sperl.org>
References: <1432574909-2326-1-git-send-email-kernel@martin.sperl.org> <556EE446.3060407@metafoo.de> <20150603115319.GF14071@sirena.org.uk> <8DBE5E2D-47ED-48D3-A185-82AF4831B0A2@martin.sperl.org> <B3BA7701-96E1-466A-90EA-121E2A85F851@martin.sperl.org> <20150618134918.GF14071@sirena.org.uk> <20150619113539.04a7fcf2@north> <20150619095346.GG14071@sirena.org.uk> <394B0003-AA2E-469F-AD9C-C291FAC60A94@martin.sperl.org> <20150619101046.GH14071@sirena.org.uk> <CAMuHMdUpGgQRD=pwywDE=nKK8p3CQoFFuRZduvXkttmc0dfRTA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	=?utf-8?Q?Jakub_Kici=C5=84ski?= <moorray3-5tc4TXWwyLM@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdUpGgQRD=pwywDE=nKK8p3CQoFFuRZduvXkttmc0dfRTA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 20.06.2015, at 14:10, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wr=
ote:
> Zero-prefixing the numbers in the filenames would make it a bit less =
ugly
> and auto-sorted=E2=80=A6
a possibility

>> histogram as a histogram might be more helpful so people might be
>> happier with debugfs.
>=20
> ... but indeed, quoting Documentation/filesystems/debugfs.txt:
>=20
> "Unlike sysfs, which has strict one-value-per-file rules, debugfs has=
 no
> rules at all."
>=20
> So storing the whole histogram in a single file sounds like the logic=
al
> thing to me.
The point with debugfs would be that we would need to start a
=E2=80=9Cstructure=E2=80=9D in the framework that can get easily extend=
ed, which obviously
would need more thought, so that a driver can easily expose additional =
data.

So something along the lines of:
/sys/kernel/debug/spi/<bus>/*
/sys/kernel/debug/spi/<bus>/<device>/*

And with the right api we could make it easily extendable (much more ea=
sily
than with sysfs...)

So what I would do I post a patch to expose those =E2=80=9Cbasics=E2=80=
=9D via sysfs and then
a patch to expose the histogram and potentially more via debugfs.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
