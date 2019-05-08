From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] spi updates for v5.2
Date: Wed, 8 May 2019 19:27:36 +0900
Message-ID: <20190508102736.GO14916@sirena.org.uk>
References: <20190506143301.GU14916@sirena.org.uk>
 <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
 <20190507021853.GY14916@sirena.org.uk>
 <20190507030241.GC14916@sirena.org.uk>
 <CAHk-=wi4EJQLoMNd4ptiiZvLy8ZW49pcCy0VQwZt4xhDDqSOjw@mail.gmail.com>
 <20190507110345.GF14916@sirena.org.uk>
 <20190507120730.5ylk6v4yvzxuzqld@earth.universe>
 <20190508060936.GH14916@sirena.org.uk>
 <20190508101301.lxwt4e6eziujdfit@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N8EXF1oXVIanxtk/"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190508101301.lxwt4e6eziujdfit@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--N8EXF1oXVIanxtk/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2019 at 12:13:01PM +0200, Sebastian Reichel wrote:
> On Wed, May 08, 2019 at 03:09:36PM +0900, Mark Brown wrote:

> > I'd have to send all mail out via kernel.org to do that, or persuade a
> > MTA to route mail differently based on contents which seems interesting
> > - I inject most of my mail via /usr/sbin/sendmail rather than SMTP
> > (including a bunch of scripts).

> I have a locally installed postfix in sender dependent relay
> configuration, which does that for me:

> http://www.postfix.org/SOHO_README.html#client_sasl_sender

I'm using exim on the central relay box which is much more painful to
configure than postfix sadly (one of these days I'll get round to
converting to Postfix since I prefer it and already use it on my client
boxes but the DKIM stuff is painful enough and there's enough stuff
using the box that it'll require me to actually sit down properly to do
something as substantial as cutting over MTAs).  It's also not clear to
me that Postfix can be configured based on From rather than envelope
sender, I have used the configuration options you're pointing at for
envelope senders before but at least at that time Postfix didn't support
setting envelope sender via /usr/sbin/sendmail.

--N8EXF1oXVIanxtk/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSrxcACgkQJNaLcl1U
h9ApdQgAgd+Tex6oCuaxwPfVHqJlxF6U9IdZ5e/tN4kqyoqXrVHGYgd8Ty++q8gD
MyNkEy2rO+N8SzvfTIlffM6E4ascQA8lXu/iSyNzeuDI12tsc0N5TxixRSDZgVWz
OQ/9hGdtUvxUipxH/lF7upTNtKEH0lylrP3iSNrnXiED3sUY4niyt+yGukCLS00T
q9gXwFNo9Dr0LoPmQ3wEwDfF+AktWDZtDlskljh709qztoeJPOzpIWPdlBgTXp+5
71u0dUMk4PQJavsDy19LYBvCH1doaTe1HLt0orwjvM5ROyJu1iYhjdWjyyTPhZ08
xuD4PXII2siLA1yJ3UIDPZjois9prg==
=QGT7
-----END PGP SIGNATURE-----

--N8EXF1oXVIanxtk/--
