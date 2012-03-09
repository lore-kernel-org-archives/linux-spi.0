From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] trivial: spi-pl022.c: fix a wrong kerneldoc comment
Date: Fri, 09 Mar 2012 14:56:41 -0700
Message-ID: <20120309215641.287F83E0880@localhost>
References: <1328718213-17375-1-git-send-email-federico.vaga@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Federico Vaga <federico.vaga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, giancarlo.asnaghi-qxv4g6HH51o@public.gmane.org,
	rubini-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org
To: Federico Vaga <federico.vaga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1328718213-17375-1-git-send-email-federico.vaga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed,  8 Feb 2012 17:23:33 +0100, Federico Vaga <federico.vaga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Signed-off-by: Federico Vaga <federico.vaga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-pl022.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 2f9cb43..286572d 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -1495,7 +1495,7 @@ out:
>  
>  /**
>   * pump_messages - Workqueue function which processes spi message queue
> - * @data: pointer to private data of SSP driver
> + * @work: pointer to the pump_messages work structure within pl022 structure
>   *
>   * This function checks if there is any spi message in the queue that
>   * needs processing and delegate control to appropriate function

Patch obsolete after applying the core-queuing patch from Linus

g.

> -- 
> 1.7.7.6
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
