From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: RE: [PATCH 0/4] Enable SPI flash support on da850-evm DT kernel
Date: Sat, 02 Mar 2013 23:13:55 +0000
Message-ID: <20130302231355.5CD2D3E34C9@localhost>
References: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
	<512DC65D.7080603@ti.com>
	<A73F36158E33644199EB82C5EC81C7BC3EA47FEF@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org"
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
	"linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	"devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org"
	<devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
	"rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "hs-ynQEQJNshbs@public.gmane.org" <hs-ynQEQJNshbs@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>, "Nori,
	Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <A73F36158E33644199EB82C5EC81C7BC3EA47FEF-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 27 Feb 2013 11:32:39 +0000, "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org> wrote:
> On Wed, Feb 27, 2013 at 14:09:57, Nori, Sekhar wrote:
> > On 2/25/2013 4:14 PM, Manjunathappa, Prakash wrote:
> > > Patch enables support for m25p80 SPI flash support on
> > > da850-EVM.
> > > 
> > > Testing information:
> > > da850-evm comes with partitions specified in DT blob.
> > > Able to mount/umount and create/delete files on filesystem partition.
> > > 
> > > Depends on below patch in spi-next branch of git://git.secretlab.ca/git/linux-2.6.git.
> > > "spi/davinci: add OF support for the spi controller"
> > > 
> 
> Grant,
> I could not find binding documentation changes submitted with above patch.
> I checked in spi-next and linux-next.

It must have been missed then. It happens sometimes. Can someone submit
a fixup patch please?

Thanks,
g.

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
