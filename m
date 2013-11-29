From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 22/31] spi: tegra: use reset framework
Date: Fri, 29 Nov 2013 15:48:31 +0100
Message-ID: <20131129144830.GD9712@ulmo.nvidia.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-23-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
	pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384548866-13141-23-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2013 at 01:54:17PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> Tegra's clock driver now provides an implementation of the common
> reset API (include/linux/reset.h). Use this instead of the old Tegra-
> specific API; that will soon be removed.
>=20
> Cc: treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
> Cc: pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
> Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.
> ---
>  drivers/spi/Kconfig              |  3 +++
>  drivers/spi/spi-tegra114.c       | 18 +++++++++++++-----
>  drivers/spi/spi-tegra20-sflash.c | 18 +++++++++++++-----
>  drivers/spi/spi-tegra20-slink.c  | 18 +++++++++++++-----
>  4 files changed, 42 insertions(+), 15 deletions(-)

Reviewed-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmKk+AAoJEN0jrNd/PrOh8a8QALiJ+HSjouDfF2N6/YlQrSUY
eH+DgTHz/IG2BvsUagXIjh18exyKMiQwI+o2BanP1tWqE1vEiiDKbNNA6bqH2bJl
dAspPUfmAHynmOxJ9t9JO/5+3rc2g604CTfnOnfOq2N7GgmNIwVm5zJFn3eq6UfU
6sFIZJcM2QJnbffgLZThP6ReAJ0f0oK/GeOfofeClT3g9fJtWxgngaZliyVGnG9I
qt+LOPF8sjg8fagJKxC2UTlRsNpU8NAnZPlBcHLLxZRRGc/sIWFeyX8nVpY9589w
rHoEp4ciJYDafsTizJLpppBgtGMs6hMjC7+6ykB+XDTIMUKaOOl5f70wHgl8gtab
gn0QUCFrDQ+w5dqDq2rdP6ymkn7zinOaR4eyqIKyRp4bQXmc1c5VkUxczAkQPW5T
w/cqF4xiDknk3Tmjg1nVOxl8KCfBfvlW/pXfkK5MXupG8jCovq1H1g8IhvMzb3HR
YaYuecMLU3tOd0PbYxhOIGZelSoknHKPcCClgloIZbg4utPgRTqilIHEdxTZa9ip
hoMu9BUPh/4y5Jpp4iKW+OqH/d5eHOteotd+kFpXR4lN7PGJOkqg+tkbtlfi7Ur8
jeJC0OB0DDbTiSUsU12922TYFM1/TkQTi/J/kSeIgom6WxZ8t7rrYi1yt3FIy/I8
i0zZHnG6BkpKJpUjy2Ht
=vmT0
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
