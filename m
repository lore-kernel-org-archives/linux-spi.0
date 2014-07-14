From: Harini Katakam <harini.katakam-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [RFC PATCH 1/2] spi: Add support for Zynq QSPI controller
Date: Mon, 14 Jul 2014 07:22:24 +0000
Message-ID: <10e00662-1e08-4552-aae7-1e2029e56238@BY2FFO11FD051.protection.gbl>
References: <1404982207-4707-1-git-send-email-harinik@xilinx.com>
 <1404982207-4707-2-git-send-email-harinik@xilinx.com>
 <CAMuHMdXO-PkQ+07F=aZEjvH1Kh7uhWK8i3V9w+1aHvvtg7wDoQ@mail.gmail.com>
 <CAFcVECJ93Lw1MRVU-=zLRbB6To--zmAxz8OLObu=mhV84-FTNA@mail.gmail.com>
 <CAMuHMdU2HyCwXBJTAyswyj7XqhzhHQ24MamGLLVgMwU4xi0kxQ@mail.gmail.com>
 <CAFcVEC+-bM91WmfwweDdTvJ7KwH+dxKDLkzsT82snWKhukLeYQ@mail.gmail.com>
 <20140710120120.GD30458@sirena.org.uk>
 <CAFcVECJvvch9Li0WihqoWcGNMMDVXfrujLUq6wvca46FztYpzA@mail.gmail.com>
 <20140710150713.GJ30458@sirena.org.uk>
 <03CA77BA8AF6F1469AEDFBDA1322A7B748213306@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	=?iso-8859-2?Q?Marek_Va=B9ut?= <marex-ynQEQJNshbs@public.gmane.org>,
	Artem Bityutskiy <artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah Choudary Kalluri <punnaia
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <03CA77BA8AF6F1469AEDFBDA1322A7B748213306-4lKfpRxZ5enZMOc0yg5rMog+Gb3gawCHQz34XiSyOiE@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

My mail seems to have missed the below reply.
Anyway, please find my answer below:

> -----Original Message-----
> From: Punnaiah Choudary Kalluri
> Sent: Monday, July 14, 2014 12:03 PM
> To: Harini Katakam
> Subject: FW: [RFC PATCH 1/2] spi: Add support for Zynq QSPI controlle=
r
>=20
>=20
>=20
> >-----Original Message-----
> >From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> >Sent: Thursday, July 10, 2014 8:37 PM
> >To: Harini Katakam
> >Cc: Geert Uytterhoeven; Grant Likely; Rob Herring; Pawel Moll; Mark
> Rutland;
> >Ian Campbell; Kumar Gala; linux-spi; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> >devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; David
> Woodhouse;
> >Brian Norris; Marek Va=B9ut; Artem Bityutskiy; Geert Uytterhoeven; S=
ascha
> >Hauer; Jingoo Han; Sourav Poddar; Michal Simek; Punnaiah Choudary
> Kalluri
> >Subject: Re: [RFC PATCH 1/2] spi: Add support for Zynq QSPI controll=
er
> >
> >On Thu, Jul 10, 2014 at 06:09:55PM +0530, Harini Katakam wrote:
> >> On Thu, Jul 10, 2014 at 5:31 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> wrote:
> >
> >> > How does the client driver select the width to use for a transfe=
r?
> >
> >> This controller is meant to be used only with flash devices.
> >> The flash devices' supported width will be reflected in a table in=
 MTD
> layer.
> >> When selecting, priority is given to quad over dual and single in =
the MTD
> and
> >> it will send commands using the supported tx/rx bus width accordin=
gly.
> >> About the supported bus width on board, tx-bus-width and rx-bus-wi=
dth
> >> properties in dts will have the info; which I believe spi core use=
s.
> >
> >If it's only intended to be used as a flash controller (and might
> >misbehave if used as such, if the command detection false triggers) =
then
> >it is probably better to support it as a flash controller rather tha=
n as
> >a SPI controller.  Or can the flash-specific features be disabled?

There is provision to switch to legacy (generic spi) mode but it is not=
 usually used.
As you can can see, the flash related specifics come into play only whe=
n two flash devices
are used. For a single slave, it will be generic.
As per your suggestions, I could send this driver in multiple stages -
Initially, qspi driver without flash specifics (this will work straight=
-away for a single flash)
In the next set, flash specifics changes for dual flash configurations =
(parallel/stacked)
Is that acceptable?

Regards,
Harini
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
