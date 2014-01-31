From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/5] spi: sunxi: Add Allwinner A31 SPI
 controller driver
Date: Fri, 31 Jan 2014 16:03:28 +0000
Message-ID: <20140131160328.GI22609@sirena.org.uk>
References: <1390993850-9054-1-git-send-email-maxime.ripard@free-electrons.com>
 <1390993850-9054-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140129122520.GY11841@sirena.org.uk>
 <20140129133227.GQ3867@lukather>
 <CAGa+x854huSmiWmEv2EgOPUgZKcp3iitNaBvKXt8DiEj8msSVg@mail.gmail.com>
 <20140131081147.GC2950@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RelyVQTGfPeWBXwZ"
Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBZ4SV6LQKGQE7XKWPQY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140131081147.GC2950@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--RelyVQTGfPeWBXwZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2014 at 09:11:47AM +0100, Maxime Ripard wrote:

> Wouldn't it be better if it was suspended by default, and just waken
> up whenever the framework needs it?

The aim should be to come out of probe in that state if runtime PM is
enabled but don't do it with these hacks, do it by idling the device
at the end of probe for example.  Apart from anything else this code
just looks ugly.

--RelyVQTGfPeWBXwZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS68lNAAoJELSic+t+oim9iSAP/js3AxmDpVbHs3m7d+fv68Fw
CsZOZdFbQgi0NB/XqQPCK/EJT/yGQs9nXyTzyPAGRi5Dn9Nu4Xc5JLFu24m15eg2
RNWATXq6sftb7Mk3Khp5yrdrF9XfjUUAuO5Jki/Gc5k6QrJvRm468bU1BjtoDx3C
37KyXjl1XxqYGeGQmnj4om09FYdqCbzAok1mxsa9kXQELs4LVq2096YcVxSzesJu
OPRRU6oBAap9kqXv7+V58V0/F0FHZmz5OytE7FsGHghc88dbQ0UVUtx+NU2egy2k
T3lcYbE51hGL41mryK3hv7D4xygWbxTUVnmBD4RcItTeaLekWvkAREe2Pug2rVx5
egyZBbU5xniXBE+RkLYmENDm4uAfeT1UjJOaY+azfSVKp63dtMZDLTWyN6vl9NJ+
pJUOsvspdCMBlmPlSNZ0x56sgDehK9o1rVRVvaWNFaUFGmzx5m3cfYTDdnBCsvWx
3qM3KODnFAok+s+j0HyNUMeyKiRdx9U1otHdmSZ1ilynxvRrTFRs+eNnreSscQDS
euroErykTPM7ZGy2DKg81xyjLqK86DqjhlHnQjk+1Jgtfv3YPTojNUth3w5JAjA1
8652xz16QY+pajsDABw2WjklnxR4qBH4kpl7BsPGeRFcy71aJeDTIcKPqtZf+TrR
FZ1HLs8M7Lo/KhS3zpmz
=N6v6
-----END PGP SIGNATURE-----

--RelyVQTGfPeWBXwZ--
