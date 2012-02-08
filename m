From: Kyoungil Kim <ki0351.kim@samsung.com>
Subject: RE: [PATCH] spi: Add the use of DMA config operation
Date: Wed, 08 Feb 2012 19:34:28 +0900
Message-ID: <000101cce64d$3c778d80$b566a880$%kim@samsung.com>
References: <000401cce62e$3c0cd5e0$b42681a0$%kim@samsung.com>
 <4F3248ED.8030408@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: 'Sylwester Nawrocki' <s.nawrocki@samsung.com>
To: spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <4F3248ED.8030408@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

Sylwester Nawrocki wrote:
> Hi,
> 
> On 02/08/2012 07:52 AM, Kyoungil Kim wrote:
> > Config operation is separated from request operation in DMA common operation.
> > Because spi driver can change the DMA config for every message.
> > So this patch is using the separated DMA config operation.
> >
> > Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> > Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
> > ---
> >  drivers/spi/spi-s3c64xx.c |   35 +++++++++++++++++++++--------------
> >  1 files changed, 21 insertions(+), 14 deletions(-)
> 
> I'm getting following compilation errors with this patch:
> 
>   CC      drivers/spi/spi-s3c64xx.o
> drivers/spi/spi-s3c64xx.c: In function 'prepare_dma':
> drivers/spi/spi-s3c64xx.c:268: error: storage size of 'info' isn't known
> drivers/spi/spi-s3c64xx.c:269: error: storage size of 'config' isn't known
> drivers/spi/spi-s3c64xx.c:278: error: 'struct samsung_dma_ops' has no member
> named 'config'
> drivers/spi/spi-s3c64xx.c:286: error: 'struct samsung_dma_ops' has no member
> named 'config'
> drivers/spi/spi-s3c64xx.c:269: warning: unused variable 'config'
> drivers/spi/spi-s3c64xx.c:268: warning: unused variable 'info'
> drivers/spi/spi-s3c64xx.c: In function 'acquire_dma':
> drivers/spi/spi-s3c64xx.c:302: error: storage size of 'req' isn't known
> drivers/spi/spi-s3c64xx.c:302: warning: unused variable 'req'
> 
> Which tree has it been created off of ?
> 
> It seems there are some patches not yet in mainline that it depends on.

I'm sorry, I thought that the dependant patch was already in mainline.
I'll re-send it with dependant patch.

Thank you.
Best Regards.
