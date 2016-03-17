From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: sun4i: add DMA support
Date: Thu, 17 Mar 2016 11:43:08 +0000
Message-ID: <20160317114308.GF2566@sirena.org.uk>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
 <1456466217-6793-2-git-send-email-plaes@plaes.org>
 <20160226122504.GR18327@sirena.org.uk>
 <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA@mail.gmail.com>
 <20160306214206.GW8418@lukather>
 <CAOMqctQ5aq0A95ErVVF13f_8JBy0xRw9_FZ3avbYmZUGXp=Svg@mail.gmail.com>
 <20160317072721.GJ30977@lukather>
 <CAOMqctQzMhR_bf=rMyROcTAPcrgx2EBqhH+qJL=b-U=iG9ZF4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nYjNOXWpwjVqWAsU"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctQzMhR_bf=rMyROcTAPcrgx2EBqhH+qJL=b-U=iG9ZF4Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--nYjNOXWpwjVqWAsU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 17, 2016 at 11:58:05AM +0100, Michal Suchanek wrote:
> On 17 March 2016 at 08:27, Maxime Ripard

> > You're mixing two things up: the fact that we can't do more than the
> > FIFO length in PIO and that we're missing DMA support. We have patches
> > to address both, and there's no depedency between the two.

> The only thing is that although DMA is optional on pretty much any
> system you will have DMA available unless you broke your config. You
> really do want the DMA support when it is available. So there will be
> nobody testing the non-DMA part and it will be prone to bitrot.

Well, it might be worth doing PIO for very short transfers even if you
have DMA - it's quite common for this to perform better.

--nYjNOXWpwjVqWAsU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW6phEAAoJECTWi3JdVIfQ/sYH/1nmKqQ6Kvej3uyHfBm8xUpE
FCQx45QqITlfNBORJz0nykBe35bhOkMVQQeApGMX9WXOF4VOA/3P6Jq3wi7WPSoJ
0tuTrfarY14HcTRan3nOdD5k2T5vwpmBlettP+iu8erJUDP3UzA0kzMpi1cvLUfm
YVnF1woIlaQ9uExmm7Qr4f4B29h4q/bK8r1/keB+0riREKvJafLlP6lMQ7pkslVj
yimiQe44aMOWtxB1zfDpLD8tyEqpXWUnxe/s1hT70AAHswQo9P+GtYl4L36fFnMN
o3IwqHxxkv8mTDuHFpNghXf4h7BnOua6QkBJSqa1EgKlYS6atsbZM7uP1OI+gv8=
=Q7vu
-----END PGP SIGNATURE-----

--nYjNOXWpwjVqWAsU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
