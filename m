From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Tue, 15 Oct 2013 21:52:54 +0100
Message-ID: <20131015205254.GX2443@sirena.org.uk>
References: <52568AA3.9080203@ti.com> <20131011100839.GA21581@sirena.org.uk>
 <525CDB77.4040201@ti.com> <20131015111647.GX2443@sirena.org.uk>
 <525D2BB3.4020705@ti.com> <20131015124656.GM2443@sirena.org.uk>
 <525D41E2.30206@ti.com>
 <20131015180142.GS23337@ld-irv-0074.broadcom.com>
 <CA+7tXigv1Q3BPE3uhzdJpx3DsqUpxzrBUaPfWR-i15PsVtMWsQ@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA23640@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5141745901950239230=="
Cc: Peter Korsgaard <peter@korsgaard.com>,
 Brian Norris <computersforpeace@gmail.com>, "Balbi, Felipe" <balbi@ti.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, "Poddar,
 Sourav" <sourav.poddar@ti.com>, Trent Piepho <tpiepho@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: "Gupta, Pekon" <pekon@ti.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA23640@DBDE04.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============5141745901950239230==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/YLrkxBeBoBPjrwx"
Content-Disposition: inline


--/YLrkxBeBoBPjrwx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 15, 2013 at 06:33:23PM +0000, Gupta, Pekon wrote:

> Therefore early suggestions were to make 'MM_MODE' as default
> (if device enables it via DT). This means:
> (1) switch to 'SPI_MODE' _only_ when required for commands like
>  mtd_erase, etc. and switch back to 'MM_MODE' when done.
> (2) And keep your controller clocks on.

This sounds like a policy decision, I don't see any reason for it to be
in DT.  What works well with one application stack may not be the best
choice for another and future developments may change what's most
sensible for a given system, it shouldn't be fixed in the DT.

--/YLrkxBeBoBPjrwx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXasjAAoJELSic+t+oim9XQYQAIbqx6PvqoKwR//xJ3tMl6Ff
gUmrheVi8wRg7RIkfTq6C1L7Y6/Pr+KsaQ4v5xhWZVTLj7L89ZJgNVItbmxyP45k
2QG13aZPH3DKVaC0w9na6nW7IkN/LH0mO9XkKCNd4vCKnYW2Au5lroJxB0Q5QfdD
cQXEYOy9kSm9zzCB9BDpo830zmrZ/DjT1+2vTZa7WIsggbEgvv6HCaIVczkgt2Ef
w+YArwPVkSe/gD97I5bmYLco89l1YpBRp/gfW2QS9H3GbR0FYPLJQ598wK+dmjr3
Y9/IhU1jcJBMWrhnORpFN7SX7pin9Q5/sKtLJH7O9rWpS95FPST6yNrNrrVOhUsT
8ikL/IQixMu9C6Fq5qLgpiosEIrvmOPw+p1QjcclyWGfPuO79LRUvc+XNrHlDIVQ
HADNS0+TziVu+mZUszoVNiz3ZmeWrAELOnaMuvHTaxqAPPjVaGgfZm02Ut5YPp3S
ib7cOaj5E1u/nntfnwKkoUuP30uHNL4nfEOtHTAliwj7RPClJWqt+sy9b67bdSYR
iokA+qhl2Fe+OB7D1IPYYVAbJGtDfErkaffZORVSiF4OVzfhiSC544RcpPHDCJkB
9LktqRCEU82iDcdG5aheb15ibI9o3VVJqs9nP+bf4VwXn+ODfMYItzBlWURRk/Ad
fLBWsI7CXNpJEfcKBTBJ
=I+jp
-----END PGP SIGNATURE-----

--/YLrkxBeBoBPjrwx--


--===============5141745901950239230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============5141745901950239230==--
