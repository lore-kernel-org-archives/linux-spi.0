From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: follow the updated samsung DMA
 common operations
Date: Fri, 8 Jun 2012 07:45:41 +0800
Message-ID: <20120607234540.GU14525@opensource.wolfsonmicro.com>
References: <011701cd42eb$a4209940$ec61cbc0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3337777093467901922=="
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
	'Russell King - ARM Linux' <linux@arm.linux.org.uk>,
	'Vinod Koul' <vinod.koul@intel.com>,
	'Grant Likely' <grant.likely@secretlab.ca>,
	kgene.kim@samsung.com, spi-devel-general@lists.sourceforge.net,
	'Dan Williams' <dan.j.williams@intel.com>,
	linux-arm-kernel@lists.infradead.org
To: Boojin Kim <boojin.kim@samsung.com>
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <011701cd42eb$a4209940$ec61cbc0$%kim@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org


--===============3337777093467901922==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R7Dyui215VKdTDYA"
Content-Disposition: inline


--R7Dyui215VKdTDYA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 05, 2012 at 04:20:10PM +0900, Boojin Kim wrote:
> This patch uses config() function to configure DMA transmit options.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

It'd be good if we could get all the older Samsung platforms moved over
to dmaengine...

--R7Dyui215VKdTDYA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP0TzNAAoJEBus8iNuMP3dikYP/0j0t9g6Z4T9/ggRCjxZ1BOq
S/hrpZS37A9ZpqB1r08kxtGPQpu2NVC0x6mJYA389CdI3A9nRw8swlOlMtJhC665
tbr9Wzgyl21O+HliJVFPYqgNx/92Y7tj+Qk9HJsMFjtxljWd83Y7sJlJ937TfmBp
HATJ81ykhk9tUEiRw4h6tr0tr2ij+aomU+trO26xtiqrbdwikRzwEB9XYaHTylup
GptyiH1qRGTVUJyKQMQUE9OxvRAqPrdYpXu9AyuS9UsC8ppp6e6dGTdVCBHefAY0
YGzTLDaKhHzvj5cc/oFQdSC+wA02tnI83pcwV2eebNxDuv5GdQ7LBCQTKsOtw1tK
wQ9vlNdQF4WoECu2IrlAzYM/MiyELO1YwC4SLeERkyvw5ufEeZgYwQIYoP90sTdK
UWB/E+CY/SnpEwiQ7DiYMYBAqePRIDWtwYVxZhCp6/RZ1vt8lC4ZhZin7kNV+ZvJ
FAiUJQ5vcJFIlVRez+5I/1Q48tjcSds5yM+SCcUYmPHZuFqdp0AWcjA7Kvr0vr5V
Gtr/6rjbABVHfaElIhVryvnllVIoXOMC1ltSbnUbphStfkwq54oIyTaWDkOVuFh3
RSElSYZ5cnkVuIZmMnDCQkx0GhfgWlI6odbM1dpo8Ua7co5FWVtkybF9AJarAkj9
BsdTQDiPZWuhh7cxDRI0
=GqL5
-----END PGP SIGNATURE-----

--R7Dyui215VKdTDYA--

--===============3337777093467901922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3337777093467901922==--
