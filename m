From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: rspi: fix the bug related to mount/remount jffs2
Date: Mon, 6 Feb 2017 12:46:39 +0000
Message-ID: <20170206124639.eoxom7dxspippjmg@sirena.org.uk>
References: <1486342933-5307-1-git-send-email-cv-dong@jinso.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2s4xjzccmrydf36f"
Cc: geert+renesas@glider.be, linux-spi@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com,
        ryusuke.sakato.bx@renesas.com, linux-renesas-soc@vger.kernel.org,
        nv-dung@jinso.co.jp, h-inayoshi@jinso.co.jp, cm-hiep@jinso.co.jp
To: DongCV <cv-dong@jinso.co.jp>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1486342933-5307-1-git-send-email-cv-dong@jinso.co.jp>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--2s4xjzccmrydf36f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2017 at 10:02:13AM +0900, DongCV wrote:
> From: Dong <cv-dong@jinso.co.jp>
>=20
> This patch fixes the output warning logs and data loss when
> performing mount/umount then remount the device with jffs2 format.

This is not a good changelog since it does not describe what the problem
with the driver is or how the change fixes it - it just says that there
is a problem.

> This is the warning logs when performing mount/umount then remount the de=
vice with jffs2 format:
> "root@linaro-naro:~# mount -t jffs2 /dev/mtdblock2 /mnt/media
> [ 3839.928013] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not f=
ound at 0x03b40000: 0x1900 instead
> [ 3839.956515] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not f=
ound at 0x03b40004: 0x000c instead

Please think hard before including long log messages in upstream
reports, they often contain almost no useful information relative to
their size so often obscure the relevant content in your message.  Some
subset is usually much better (eg, "produces lots of errors like X"
here).

--2s4xjzccmrydf36f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliYcCwACgkQJNaLcl1U
h9CnLwf+L9y7K6gJJf+2smFlZeRtjGo5S9xLsp7VIvppXfKRWgYEsdRHW3jO3Z28
/8gIUFgYcW9HzhXVx1To7h1+9Q3A2SPy7QPV4ccGszAqnKxc/FOpRI+JcEuQ5RoY
rNMt94YbDJnio8/uuY1nSmE3TRa780UDmgjRuINJ1nZ1ErMtsqboRIVui6qb9W0z
6P30fdqK0iRR7znsk6cWSit68HKojbRwqHu0dgSscP+qcgoK+Fzx/Gmvm3UuPdsr
DUKERuwb5FM5KIdEv/W3UNe7JvgvnFSetE3O8W/bw1LUOWz47XV56DJ21vSClnRl
Zwd9AyRXpMQdXmyluuUnWutHm2P/Dw==
=G8g/
-----END PGP SIGNATURE-----

--2s4xjzccmrydf36f--
