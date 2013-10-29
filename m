From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Tue, 29 Oct 2013 09:39:26 -0700
Message-ID: <20131029163926.GA6776@sirena.org.uk>
References: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com>
 <20131019162504.GA1863@sirena.org.uk>
 <CAPs=JDeOqkJT32quBH1tF9FtFUOt=CHP7m6ZqzhfASM2uPj-dw@mail.gmail.com>
 <CAPs=JDdzvnM5BzgRLhLsJrdwcVSwxd6x8_kFz0EvB=OjFfVszw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Cc: Rajeshwari S Shinde <rajeshwari.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: Rajeshwari Birje <rajeshwari.birje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPs=JDdzvnM5BzgRLhLsJrdwcVSwxd6x8_kFz0EvB=OjFfVszw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2013 at 04:59:11PM +0530, Rajeshwari Birje wrote:
> On Tue, Oct 29, 2013 at 4:29 PM, Rajeshwari Birje

> >> This patch is still not setting bits_per_word_mask as far as I can see?

> > Will send new version of patch including this.

> I had some confusion regarding this bits_per_word_mask, where do you
> want me to mask the bpw.
> bits_per_word is something which comes from the user, do we need to mask it?

Have you looked at the code and documentation for this feature - if it's
not clear can you please explain in more detail what needs clarifying?

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSb+S7AAoJELSic+t+oim96MQP/2ZJLGnByWlPui08B3QNbDk4
Em68UlqKa3wWUCrCFdeUwn0FTqavuDUt6fZSx/ZXvXlCPkOhbu/BXO9XGkFgWVCf
xJYD9TfakOR/woGZj/fmDtn8OJQw9dWDF3WMzwMadd8A8EFgdMOdgHnDavTuxHT/
Tn0Yfgw0f+DuAnTRU3kdBb3w4R8KNvnXaF1Bjx5d/WGgIGCHavFSCwibvw4tVuf9
d4WKyU+FV1R6TQ+E0XF2WRwI+MF2S7Lb5VcVg3fCWA7l1FgLYc0dgp3/lMm10B/z
5NMrjViAECEbyQIgnFuvo7SyuEQLxf+dSblVuume5FpBSu5G3OJeFCHv18YjzqCw
oE7Hj7uUfPR7buXTbBfL5WXM+xzXLcGupcx9kaZgNOkZRsVqsuYQMFC9NMnWWDql
YhocZTkgeVmYiSllnKPRIORzovdAhOMdvrlrdaXJtxNr20ayBdFPEHj8vaInBIUt
oGSzjXN7p072hKQxNszvDWmw9CNFDv5u4klndp7u4CYeJAQB6OZhOG9qpoUqxZgT
xjT+WtpGOUGj26AdTd5of2L/L1ZiRTsQm2dHi5GzzaEztm8qhnvm6Md5YXRK3DKg
rTwkWFZcNUPa/HdFpHrF3RpWRhDAQ6K+le7qZINtyOdcXAZqZB4gfbYP7wG6oFyR
dgQVRVl1MI4rVIdevOsz
=Ko0/
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
