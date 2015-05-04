From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: add spi_statistics framework
Date: Mon, 4 May 2015 15:39:10 +0200
Message-ID: <3BC3DB7A-8E03-45B5-BEB2-6E74B9597276@martin.sperl.org>
References: <1430741564-2849-1-git-send-email-kernel@martin.sperl.org> <20150504132436.GX15510@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150504132436.GX15510-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> On 04.05.2015, at 15:24, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> Two problems here:
> - This doesn't do what the subject line says it does (it's purely a
>   modification to the header).
> - This is two not obviously related changes in a single commit.
Typically (i understood) you want things as separate patches, so I=20
did split the API change from the implementation details:

Patch1/2 with the framework/API and the other with the implementation.

Also the Patch2/2 requires the =E2=80=9Cto_spi_master=E2=80=9D method f=
rom Patch1/2.

You want now everything in a single patch or you want patch 1/2
split into 2 distinct patches?

Other things that you think needs change so that i can incorporate
those as well prior to resubmitting?

thanks



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
