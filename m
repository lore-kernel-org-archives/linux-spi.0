From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] spi: Add support for Zynq QSPI controller
Date: Thu, 10 Jul 2014 14:01:20 +0200
Message-ID: <20140710120120.GD30458@sirena.org.uk>
References: <1404982207-4707-1-git-send-email-harinik@xilinx.com>
 <1404982207-4707-2-git-send-email-harinik@xilinx.com>
 <CAMuHMdXO-PkQ+07F=aZEjvH1Kh7uhWK8i3V9w+1aHvvtg7wDoQ@mail.gmail.com>
 <CAFcVECJ93Lw1MRVU-=zLRbB6To--zmAxz8OLObu=mhV84-FTNA@mail.gmail.com>
 <CAMuHMdU2HyCwXBJTAyswyj7XqhzhHQ24MamGLLVgMwU4xi0kxQ@mail.gmail.com>
 <CAFcVEC+-bM91WmfwweDdTvJ7KwH+dxKDLkzsT82snWKhukLeYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Lv0dYwq55yjFwMRW"
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Marek =?utf-8?B?VmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>,
	Artem Bityutskiy <artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	"michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punna
To: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFcVEC+-bM91WmfwweDdTvJ7KwH+dxKDLkzsT82snWKhukLeYQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--Lv0dYwq55yjFwMRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 10, 2014 at 04:03:19PM +0530, Harini Katakam wrote:

> OK. Correct me if I'm wrong but announcing this support in master->flags is
> just to say the controller supports it - Like Punnaiah mentioned in the other

No, it's broken to set this if there is no ability to use it.

> mail, nothing specific needs to be done from the controller driver to enable
> dual/quad support. This is at the SOC/IP level.

How does the client driver select the width to use for a transfer?

--Lv0dYwq55yjFwMRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTvoCHAAoJELSic+t+oim9RAkQAJz8R+eH3JIKhwdnVPZy39rq
q9oQD1jIGzuw8raIxv2ip1S9dQA11AwHBVHKGsGhxW2vcBJ+WwLKxtLrS9mGVlTh
71ER2yw4uglokBeqrBePhqUW3IPkx71YKlcde9UuB20+dlC0KLltqhY3RN7iNRKx
s2CU7xRmPuQChTvJCd97/MalpWRr+L0f9A++X6PLiTMr+TAduyAnobbFlukqURcQ
2UOGytJVKsNjsuSmI32ai/JPTWRekv/iakVG+IFmlXjQsAry4Zg/9LbclP157yv+
Mtsrv+uNJ5IbXtJZpezH+ZkaIqVbgsOWBaGt1BEtjeHNWKSbSvQ77k1mI5azPQYo
igA1JHAzoxoDLU4tPClF6xl7JqH1ua1MtHyWyMCTk1cJTwpHST9HhL1M1hBFfYuW
e6uO9cz1xtBSTMgNXR9OLcaye83BGE9E/rJ/Ob2wJ4+ZoVnlfo12meD+/GLZch82
HEb1qbWf1TIbCghnZ05aRJEXnYlrq1yrhskQIm+Fw+10F7muofUO30/EH9GpMNnn
xobDOeuo/TZUuDfbyxU3nyYtiZZr3YtQz1/nfmjIkGTPl2nZPhOUzT2cPGr/ZQtU
it32QdkylIs5WOkcDgxulKzSAw788Oac9QRExjOcfLIAK1B91GVj7tkr6PYxyo98
fo78SIR/V4JxvUoy9VLY
=z2by
-----END PGP SIGNATURE-----

--Lv0dYwq55yjFwMRW--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
