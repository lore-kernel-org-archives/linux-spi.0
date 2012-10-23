From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Revert "spi/pl022: enable runtime PM"
Date: Tue, 23 Oct 2012 14:01:07 +0100
Message-ID: <20121023130106.GZ4477@opensource.wolfsonmicro.com>
References: <1349452272-4002-1-git-send-email-ulf.hansson@stericsson.com>
 <1349452272-4002-2-git-send-email-ulf.hansson@stericsson.com>
 <CAPDyKFqfE0u2CPzFKeHBE1LMtuetWabR94KuASPNhw4StDCfjw@mail.gmail.com>
 <20121023111019.GV4477@opensource.wolfsonmicro.com>
 <20121023111656.GT21164@n2100.arm.linux.org.uk>
 <20121023114130.GW4477@opensource.wolfsonmicro.com>
 <20121023114723.GU21164@n2100.arm.linux.org.uk>
 <20121023114842.GA4293@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0258657318749821608=="
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Vipul Kumar Samar <vipulkumar.samar@st.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Grant Likely <grant.likely@secretlab.ca>,
 spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121023114842.GA4293@n2100.arm.linux.org.uk>
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


--===============0258657318749821608==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wn0J+vu9+NMIXK57"
Content-Disposition: inline


--Wn0J+vu9+NMIXK57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 23, 2012 at 12:48:42PM +0100, Russell King - ARM Linux wrote:

> Oh, and if you're unwilling to do that, then I'm taking both of Ulf's
> patches, committing them to my fixes branch, and sending them off to
> Linus tonight - because they are _NEEDED_ for the -rc series to fix
> this driver.

As I said in my previous e-mail I've now done the revert myself; I'll
send the fixes to Linus.  If you wish to check the other patches that
are queued they're in -next like I said; I'd appreciate someone who's
actively using the driver taking a look at them.

--Wn0J+vu9+NMIXK57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhpUMAAoJELSic+t+oim9AO4QAIBm1gZf1UdFn56uO/X2M7qr
wTYVTMNCeeaYgt/TL6NzMHBBg+kfEDENPVcvdnUum4dA9UqKtvMKN+8SHYTWn5+h
v0IfPxUNJ4wFW4iMarzuPhmAzf8cHu3+zBxkP1yWJqSZUvovQzpcRiOVsmCW4nbU
dTq2TJZ6iSCpdoJbc0sp9b6+pfKcuupa1cP4AXBaDTLFSg6HFU6V1mQa1CvYP6lL
kbJl+jsKBKy3KIfgaB/mqTMMBxouOGjslRIwFw/Q4KVEA6V4gsm/LeOYiACEEZ1u
xtGscqYJ9mIam2nZD0xSLeepqop2eZaLPiQj/hpDMV2CBm/MUjr9jeYyZvCirRVn
JDODuuEgOm7MVM8vy0fUuvcyXIeFcynYXSkL/4uWD71IQI3Cu82tjSo5UENwht7A
oIzGsaMmthDJibCiv2RuJRmPyU03rd7nlI3PtPJnE9+4kwTgvxWZfNovGT8ds/0l
5s0zJNnuASDxpLAj4ELxWKwzhOhZopfXl5AffBP5zkkivgjZ5as3xTHMEqTs4wSh
E3cqgtuNTO/5GHlmqtbXrxFNtTrPgnSU16GNjMt8BnseXCJLiovSBm7DM3jlazhF
fg6DVI/ZR6WHUzFMcegoWtL60pN5Smh9393de58Ep3Px2LCACmDHRhfaFcdkja+c
LgNCMd2YEgrxr2TKSE3a
=4WD0
-----END PGP SIGNATURE-----

--Wn0J+vu9+NMIXK57--


--===============0258657318749821608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0258657318749821608==--
