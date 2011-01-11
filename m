From: "Tomoya MORINAGA" <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: RE: [PATCH 1/3] spi_topcliff_pch: support new device ML7213
Date: Tue, 11 Jan 2011 18:38:35 +0900
Message-ID: <84FF3503839A46E0B9919DF000DDE5C5@hacdom.okisemi.com>
References: <1293449027-3219-1-git-send-email-tomoya-linux@dsn.okisemi.com><20101229064937.GC8172@angua.secretlab.ca><280596192AA74D208C2C5F6389DBE8C1@hacdom.okisemi.com><20110105163835.GD17272@angua.secretlab.ca><46862922F48B45F781832619CF3F4B79@hacdom.okisemi.com>
	<topcliff-split@mdm.bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: 'David Brownell' <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "'Wang,
	Qi'" <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Toshiharu Okada <toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>,
	kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	'linux-kernel-u79uwXL29TaiAVqoAR/hOA49XUYAGyU/@public.gmane.org@intel.com', joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: "'Milton Miller'" <miltonm-ogEGBHC/i9Y@public.gmane.org>,
	"'Grant Likely'" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <topcliff-split-kM9DGJe42AJBDgjK7y7TUQ@public.gmane.org>
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

On Friday, January 07, 2011 6:22 PM, Milton Miller wrote:
> follow mfd_add_devices into drivers/mfd/mfd-core.c
I have also seen mfd-core.c.
However, I couldn't clear my question.

Q1. It seems platform_device is not used in your example. Does need "platform_device" ?
Q2. How detect pch_spi channel dynamically ?

I want to catch your saying correctly.
Could you give me more information ?

Thanks,
-----------------------------------------
Tomoya MORINAGA
OKI SEMICONDUCTOR CO., LTD.


------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
