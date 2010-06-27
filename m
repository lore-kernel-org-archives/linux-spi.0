From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/3] davinci: spi: replace existing
 SPI driver
Date: Sun, 27 Jun 2010 10:25:44 +0200
Message-ID: <4C270B08.2000104@kernel.org>
References: <1276530901-4413-1-git-send-email-bniebuhr@efjohnson.com>
	<AANLkTilTTgTchq_w0CktXokOxGX32lmRyPqrTyFI9LCF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	Thomas Koeller <thomas.koeller-x9WYMywdo8BF6kxbq+BtvQ@public.gmane.org>,
	Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sandeep Paulraj <s-paulraj-l0cyMroinI0@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTilTTgTchq_w0CktXokOxGX32lmRyPqrTyFI9LCF-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello,

On 06/27/2010 08:03 AM, Grant Likely wrote:
> Any users of the current davinci_spi driver care to comment on this
> series?  I'm hesitant to apply a complete replacement to a driver that
> was only added in December without having a lot more information.
> 
> Tejun or Sandeep, any comments?

Eh, I don't really have any idea about the code.  My only commit there
is slab.h inclusion cleanup which doesn't require any specific
knowledge of the code, so... no useful comment from me.

Thanks.

-- 
tejun

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
