From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Revert "spi/pl022: enable runtime PM"
Date: Tue, 23 Oct 2012 12:41:31 +0100
Message-ID: <20121023114130.GW4477@opensource.wolfsonmicro.com>
References: <1349452272-4002-1-git-send-email-ulf.hansson@stericsson.com>
 <1349452272-4002-2-git-send-email-ulf.hansson@stericsson.com>
 <CAPDyKFqfE0u2CPzFKeHBE1LMtuetWabR94KuASPNhw4StDCfjw@mail.gmail.com>
 <20121023111019.GV4477@opensource.wolfsonmicro.com>
 <20121023111656.GT21164@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6806139976125388173=="
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Vipul Kumar Samar <vipulkumar.samar@st.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Grant Likely <grant.likely@secretlab.ca>,
 spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121023111656.GT21164@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============6806139976125388173==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NO4xtVTk6ycZDAf4"
Content-Disposition: inline


--NO4xtVTk6ycZDAf4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 23, 2012 at 12:16:56PM +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 23, 2012 at 12:10:19PM +0100, Mark Brown wrote:

> > I *really* should not need to remind you to:

> >  - Not top post
> >  - Send patches in a form which can be applied if you want them applying

> How about actually applying the damned patch from the two-part patch set,
> rather than only the first, both of which has been around for almost a
> month now, and fixes what should never have gone into mainline in the
> first place?

Well, the reason for the second point is that I don't have a copy of the
patch any more, I need a copy of it before I can do anything.  Half the
reason these contentless top posts are annoying is that even if there's
something to do it's not actionable.

I have to say I had been under the impression that Linus' series that I
applied the other day dealt with all the outstanding stuff here; the
issues with this have been the awful changelogs and the overalapping
sets of patches.

--NO4xtVTk6ycZDAf4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhoJkAAoJELSic+t+oim9cDUP/ApWXPlP22TsJbMDA1u4O5wt
PiAdOz/1dWPfjfowvB/PwzMH+N7r5V8Fb5NONX2cl32Y+nw6xEuSL57e9pQPjPFD
dM6pYumuJ8JjpSdD7M6rKck5/844vKjBHYgYSYSxKcb13yAm1d49pGUX5ADfky/M
pdYi5iyi3gi9NpzvW3BZp2OVcF8kiztAc47CvTT0vMcgX93HMyfuR8SfwRpnIPAs
iIK0PsmkB4ZZ7NSfYXriGX/U2V9jB668/ZcLIQgwU0J/vjQkYUBN7D93UJetQJn+
NsD3WmVP1vAdNBqkHfNXHhVPulF3P+moxh7gOtXczpmTwYPOl4OATKiUxJJsJcCV
GkgTE4FDk8soQUejKeRdqAvGerfUEmzgaIL4GZwUtK0d0vyT5S4z9RRIaAf1dav1
Cw2WpN8zI7cuf/gGJ3k0nnTPnGmw010LEP5XpC/8MwX8eZJlQ+mI7zsaSovz8FrX
c9VI5rbN1LWnueXnPLPfUNUnqmpq/VNCCFlZ1qBAV1wgvn/N+BX/fzRr9mr9RrJS
8xojb6n4NSAotgnr9MESJnABczxB15tkk2zU9gHZIxMq9nsOY1jlH8LEnFGdviiN
opr6k7SqE2/x4j0+1p93gpZNFiWbLBbukxiWJ9JVZbUiXLMlGDxRUD9elPTRrqDo
ZP3TvHNfY/7kICSvLjPI
=eCRa
-----END PGP SIGNATURE-----

--NO4xtVTk6ycZDAf4--


--===============6806139976125388173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6806139976125388173==--
