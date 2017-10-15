From: Dirk-Jan Faber <dfaber-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Mode 1 on /dev/spidev1.0: invalid argument
Date: Sun, 15 Oct 2017 22:34:06 +0200
Message-ID: <AB33E321-786B-4160-A5ED-E4DA04B1EE94@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_AC8D8164-151C-4604-BAE1-55E33560F11A"; protocol="application/pgp-signature"; micalg=pgp-sha512
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Apple-Mail=_AC8D8164-151C-4604-BAE1-55E33560F11A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello list,

While connecting an as5047d sensor to my Raspberry Pi 3, I noticed =
something unexpected in the spi connection. According the datasheet, the =
as5047d works in spi mode 1 (cpol=3D0, cpha=3D1). I noticed a difference =
between `/dev/spidev0.0` and `/dev/spidev1.0`. =46rom the first device, =
I can read the sensor without problems. When I use the second device, I =
get the message:

> can't set spi mode: Invalid argument

I am aware that this can mean that either the Pi=E2=80=99s hardware or =
the software has a problem with setting the mode. I hope you can help me =
figure out which one is the case or maybe I am overlooking something.

I've put the code I use on a github gist: =
https://gist.github.com/steviethecat/49cfb90c7aaee848284647d31f4889e1
The argument for the compiled code is the device to use:

     $ ./as5047d-spi /dev/spidev0.0 | head -n 5
    spi mode: 1 bits per word: 8 max speed: 1000000 Hz (1000 KHz)
    245.52
    245.52
    $ ./as5047d-spi /dev/spidev1.0 | head -n 5
    can't set spi mode: Invalid argument
    $ uname -a
    Linux mypi 4.9.41-v7+ #1023 SMP Tue Aug 8 16:00:15 BST 2017 armv7l =
GNU/Linux

I would really like to use `spidev1.0` for the encoder, as I already =
have the `spidev0.1` device connected to another spi device.

Kind regards,
  Dirk-Jan Faber

--Apple-Mail=_AC8D8164-151C-4604-BAE1-55E33560F11A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJZ48Y/AAoJEH9IjqRGUG040w8H/2yFupgCpi8R71rOf/kEoFWJ
Vxq4NAc80oqH1CFiGEA2vCBBSeuVO7/r0kvfebSoa00snN2WYcfu4bUhOpeKnV7i
ruyFix64CvpafCb8lRqYp1ot98n4sIUcf0IE2JwjLffnKX4QXbk38pl8UYbmmBo2
VLDDxLEnvx0L6fzqKKq3jyAItmFujR7a5b04VrmF1uLx64vM84yt1NL2K6I6NpRo
cD2Tsnbbg40xbWxSq7yB/KKvJeFEODD5Ur55OvKkN1y09ERnwJBMHy0JjCw148/r
FKL8e1VSlm+S/qqtaWzsRmxYAorKvvynNUk44hnMgB9mO0lFnWpGanmRUO/FRHI=
=64wC
-----END PGP SIGNATURE-----

--Apple-Mail=_AC8D8164-151C-4604-BAE1-55E33560F11A--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
