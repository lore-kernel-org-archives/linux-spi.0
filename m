From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 3/4] spi: s3c64xx: add dma maxburst size initialization
Date: Sat, 02 Mar 2013 22:23:40 +0000
Message-ID: <20130302222340.6C4E13E2499@localhost>
References: <001b01ce10d3$e9f78620$bde69260$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Russell King' <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	'Vinod Koul' <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	'Mark Brown' <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	'Rob Herring' <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	'Sangbeom Kim' <sbkim73-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Dan Williams' <djbw-b10kYP2dOMg@public.gmane.org>
To: Boojin Kim <boojin.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <001b01ce10d3$e9f78620$bde69260$%kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 22 Feb 2013 17:09:18 +0900, Boojin Kim <boojin.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> This patch adds dma maxburst size initialization.
> The maxburst should be set by MODE_CFGn.DMA_TYPE,
> because the pl330 dma driver supports burst mode.
> 
> Signed-off-by: Hyeonkook Kim <hk619.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Applied, thanks.

g.


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
