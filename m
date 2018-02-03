From: Henry Gomersall <henry.gomersall-rFU6cQq7QtIud/4VRtRfoNBc4/FLrbF6@public.gmane.org>
Subject: Re: spidev: That spidev in the DT issue again...
Date: Sat, 3 Feb 2018 08:31:29 +0000
Message-ID: <8622f025-ceee-b9cb-9ea7-8ac77ae020dd@smartacoustics.co.uk>
References: <ef61ff15-ec38-42f0-8ef3-9235b50dfda1@smartacoustics.co.uk>
 <1517597933.25398.215.camel@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AOxxuOi5YCe8nXfiGxLfKvs0ryagKD38g"
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1517597933.25398.215.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AOxxuOi5YCe8nXfiGxLfKvs0ryagKD38g
Content-Type: multipart/mixed; boundary="7I5YaBo9YbdXeEh0hRhrWZvDIIeVGVUW7";
 protected-headers="v1"
From: Henry Gomersall <henry.gomersall-rFU6cQq7QtIud/4VRtRfoNBc4/FLrbF6@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>,
 "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Message-ID: <8622f025-ceee-b9cb-9ea7-8ac77ae020dd-rFU6cQq7QtIud/4VRtRfoNBc4/FLrbF6@public.gmane.org>
Subject: Re: spidev: That spidev in the DT issue again...
References: <ef61ff15-ec38-42f0-8ef3-9235b50dfda1-rFU6cQq7QtIud/4VRtRfoNBc4/FLrbF6@public.gmane.org>
 <1517597933.25398.215.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
In-Reply-To: <1517597933.25398.215.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>

--7I5YaBo9YbdXeEh0hRhrWZvDIIeVGVUW7
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi Trent,

On 02/02/18 18:58, Trent Piepho wrote:
>> The clear use case for more flexibility in the system is around FPGA
>> based SoCs (in my case a Zynq). In such a scenario the use of userspac=
e
>> is a natural complement to runtime configurable hardware blocks. It
>> would really ease access to (at least somewhat) correct use of the
>> driver if it could be recognised that the kernel might not actually ne=
ed
>> to know what's on the end of an SPI bus.
> I've got a patch that adds "driver_override" to the SPI bus.  This
> already exists on the PCI bus, platform bus, and AMBA bus.
>=20
> One can name the SPI device's type in the DT correctly to anything you
> want.  Call it "smartacoustics,fpga-codec-block-1.0" or whatever.  It
> doesn't have to have to be "generic" or "name-of-linux-driver".  Names
> like that are what aren't supposed to be in the DT.
>=20
> Then driver_override allows this specific device to be bound to spidev.=

>  It works for all other spi drivers too.  Suppose the device you have
> created in an FPGA is or can be compatible with a standard SPI eeprom. =

> Bind the eeprom driver to it.  Reconfigure the FPGA logic and now it
> works like a SPI controlled DAC and switch to the DAI driver.
>=20

Thanks for that. What's the status of the patch currently? I can't see
it on patchwork...

Looking back at your earlier email you point out doing this through udev
rules, which is IMO a good way to solve the problem

>=20
> It does not solve the problem of creating and destroying SPI slaves
> dynamically at run time.  This can be solved (and it way that isn't
> specific to spidev), via:
> * Copying the I2C new_device system, which allows this with limitations=

> and in a SPI (and I2C) specific way.
> * Incorporation of the dynamic DT fragment loading system, which solves=

> this with far less limitation and it manner that is not bus specific.

Is this an aspiration, a WIP, or just a thought?

Thanks,

Henry


--7I5YaBo9YbdXeEh0hRhrWZvDIIeVGVUW7--

--AOxxuOi5YCe8nXfiGxLfKvs0ryagKD38g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJadXNhAAoJEGf0MT1zztWmjSEP+gIPD4VyJV2euwUCn2OLvSMk
inu1HP3NpEneL/QzqqBpt53Tln0q3HmKvfYphdpUhOicOYIgAQSZlTdsSKjsOvd4
4GEooHDd/9Tf+Vp4oMinpuHH1Hvnzl5km3cg4zNpSMroMD/LIbXQU3zP7co/Lpoe
JBzhpsoV0r6KtoOVy3krs6Ib4WpRkTi64YaJ+5d8g5qmr8ue/wjBrXEaoL2eQS/R
jEnB9wkWa1KoLYRwhcQedr3OVW1KwQNjEkgkpaNVS08rJk9tpePRrAzu3vey2Ih3
S/F2/naMqMJJYD1e5bk9tWt9owRWuqPXuVPzUaZmPG2SbdMAUdGSv3gm5t17Y5cS
W+jgO3Bm/+MltnaTAWkovriO3GZICbNp6BIwQ6bdot5weRrfij6yv+EVqNmilfZj
wZ2z3NMIq3eqhPWijd4jCRhPHAcNLbdchGoKOw7X7a228rhLGsP1YlPMdMhF2Wkt
kfPguzcE1Gnw6vg0Pr5Y7H+AdbJYWsiGG9Ct7orTcfdBQvGDIIavosHYEAHtX+n3
hCrdzeNvcdu9+evFpAPhLWo5A+t20WyTwv4QjFhCOF595hpU6R8FPD3ZBcoMcNUX
HCIi0ewrltxVVCzIE7tBIJRlDvgFq0qEzXKcjX6f5wnBXc4I6XDcB8Lu/pucuhWb
Zl+jPlhbOQ5CTNiDZ4w7
=ZNab
-----END PGP SIGNATURE-----

--AOxxuOi5YCe8nXfiGxLfKvs0ryagKD38g--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
