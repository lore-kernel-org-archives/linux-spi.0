From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 0/1] Renaming 'struct flash_platform_data' into 'struct
	spi_flash_platform_data' in include/linux/spi/flash.h
Date: Mon, 24 Jan 2011 10:52:22 -0700
Message-ID: <AANLkTikDHbKt5q+o2LK89hHZ3EUeeYzmQVJj8jXgQ+pB@mail.gmail.com>
References: <327178.68946.qm@web180303.mail.gq1.yahoo.com>
	<4CEB89C6.3080603@bvs-tech.com>
	<20101123093643.GC6156@jasper.tkos.co.il>
	<4CEB8C39.1060801@bvs-tech.com>
	<20101123094414.GD6156@jasper.tkos.co.il>
	<4CEB8F7C.6070102@bvs-tech.com>
	<20110121192819.GA32112@angua.secretlab.ca>
	<4D3D6472.8030505@bvs-tech.com> <4D3D9FA6.3050900@bvs-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
To: Alexis RODET <alexis.rodet-zROAmvwsW6hWk0Htik3J/w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4D3D9FA6.3050900-zROAmvwsW6hWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 24, 2011 at 8:49 AM, Alexis RODET <alexis.rodet-zROAmvwsW6hWk0Htik3J/w@public.gmane.org> wrote:
> Hi again,
>
> In facts I don't know which git URL to clone for getting linux-next as patch base, can you tell me ?
> I'm working on last stable release from git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6-stable.git.

git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Be warned, it is rebased every night.

> I wonder also what to do if people keep committing new files with old structure name:
> What should I put to make the define generate a "deprecated" warning ?

The spi flash_platform_data structure is almost a complete subset of
the arm one.  Rather than renaming everything, why not simply
consolidate the structure definition?  Consolidating will have much
lower impact.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
