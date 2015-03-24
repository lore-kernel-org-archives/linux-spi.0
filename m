From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi fixes for v4.0
Date: Tue, 24 Mar 2015 14:07:27 -0700
Message-ID: <20150324210727.GA28997@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit bc465aa9d045feb0e13b4a8f32cc33c1943f62d6:

  Linux 4.0-rc5 (2015-03-22 16:50:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4=
=2E0-rc5

for you to fetch changes up to 072ac04d31b14647e9835b1a699ebe3413e5d222:

  Merge remote-tracking branches 'spi/fix/dw', 'spi/fix/queue' and 'spi/fix=
/qup' into spi-linus (2015-03-24 10:38:44 -0700)

----------------------------------------------------------------
spi: Fixes for v4.0

A couple of driver specific fixes of the usual "important if you have
that device" kind together with a fix for a use after free bug that was
introduced into the trace code in some of the recent refactoring of the
message queue handling.

----------------------------------------------------------------
Andy Shevchenko (1):
      spi: dw-mid: clear BUSY flag fist and test other one

Ivan T. Ivanov (1):
      spi: qup: Fix cs-num DT property parsing

Mark Brown (1):
      Merge remote-tracking branches 'spi/fix/dw', 'spi/fix/queue' and 'spi=
/fix/qup' into spi-linus

Uwe Kleine-K=F6nig (1):
      spi: trigger trace event for message-done before mesg->complete

 drivers/spi/spi-dw-mid.c | 6 ++++--
 drivers/spi/spi-qup.c    | 9 +++++----
 drivers/spi/spi.c        | 5 +++--
 3 files changed, 12 insertions(+), 8 deletions(-)

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEdIPAAoJECTWi3JdVIfQ/loH/07YwMydhEw6Q1nGogAJnahq
32Nrq+hKnw/p+SJBdsANWhg8FttFgji8CajQtwgPsj4/kiZGRjr+3EUwsy2bvW/n
424QVlu0cUZG6uOIAkzShcEjP+b47zT3vlRBb/aSaSaHAZQBRAMYoPxCy7aRjSQ+
HSypLLgSNRGPFrWXakfZqfZxIE3gTcXuOiJxcAjW+dGeyPHV0Cqisa9hQIeQ5Vzn
XqS7lUmWv749eY0azrmel0rXeI5/oFPS88bHO5DVGo0uI0LPVNOrnqZ5DUzFSQTA
3cfqm5/DyiYJEHyL19bdNNsgB0oTC7aqKSA1CRvg9dbONUnzgXpqf/5JiTnIDSM=
=7jhh
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
