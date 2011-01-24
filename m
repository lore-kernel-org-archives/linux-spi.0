From: "Tomoya MORINAGA" <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: RE: [PATCH 1/3] spi_topcliff_pch: support new device ML7213
Date: Mon, 24 Jan 2011 12:14:22 +0900
Message-ID: <26379C01EA414D11A4FF5A504D1E0CBB@hacdom.okisemi.com>
References: <1293449027-3219-1-git-send-email-tomoya-linux@dsn.okisemi.com>
	<20101229064937.GC8172@angua.secretlab.ca>
	<280596192AA74D208C2C5F6389DBE8C1@hacdom.okisemi.com>
	<20110105163835.GD17272@angua.secretlab.ca>
	<46862922F48B45F781832619CF3F4B79@hacdom.okisemi.com>
	<topcliff-split@mdm.bga.com>
	<84FF3503839A46E0B9919DF000DDE5C5@hacdom.okisemi.com>
	<20110121184852.GA18603@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: 'David Brownell' <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "'Wang,
	Qi'" <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"'linux-kernel-u79uwXL29TaiAVqoAR/hOA49XUYAGyU/@public.gmane.org@intel.com'"@angua.secretlab.ca,
	yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, 'Milton Miller' <miltonm-ogEGBHC/i9Y@public.gmane.org>,
	'Toshiharu Okada' <toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>,
	kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: "'Grant Likely'" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20110121184852.GA18603-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

Thank you for your explanation.

On Saturday, January 22, 2011 3:49 AM, Grant Likely wrote:
> Am I correct so far?

No, not true.
Both Topcliff(Intel EG20 PCH) and OKISEMI ML7213 IOH SPI devices
can't use multi-ChipSelect but 1 ChipSelect only.

I show the my modified diagram below.

- Currently upstreamed version,
 /sys/devices/.../0000:00:1a.0 (pci_dev bound to driver 'pch_spi_pcidev')
   |
   \--spi0.0  (spi_device 0 on spi_master 0)

- I posted before version.
 /sys/devices/.../0000:00:1a.0 (pci_dev bound to driver 'pch_spi_pcidev')
   |
   +--spi0.0  (spi_device 0 on spi_master 0)
   |
   \--spi1.0  (spi_device 0 on spi_master 1)

- Your anticipated becomes like below
 /sys/devices/.../0000:00:1a.0 (pci_dev bound to driver 'pch_spi_pcidev')
   |
   +--pch_spi.0
   |   |
   |   +--spi0.0  (spi_device 0 on spi_master 0)
   |
   \--pch_spi.1
       |
       \--spi1.0  (spi_device 0 on spi_master 1)


Still above,  don't you change your opinion?

> Make sense?
I probably understand your saying.
You mean insert platform_device as wrapper between pci_driver and spi_topcliff_pch.

Thanks,
-----------------------------------------
Tomoya MORINAGA
OKI SEMICONDUCTOR CO., LTD.


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
