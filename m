From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] spi-imx: Remove duplicate spi_imx_data definition
Date: Mon, 26 Mar 2012 16:04:52 -0300
Message-ID: <4F70BDD4.5010003@freescale.com>
References: <1332785632-17799-1-git-send-email-fabio.estevam@freescale.com>
	<CAM=Q2cvL+Dac=Q1XmSUOLZGqK2zVdYd6nzQc-Tgeywois8rrxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAM=Q2cvL+Dac=Q1XmSUOLZGqK2zVdYd6nzQc-Tgeywois8rrxQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Shubhrajyoti Datta wrote:
> Hi Fabio,
> 
> On Mon, Mar 26, 2012 at 11:43 PM, Fabio Estevam
> <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
>> Structure struct spi_imx_data is defined twice.
>>
>> Remove one of its definition.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>> ---
>>  drivers/spi/spi-imx.c |   20 +++++++++-----------
>>  1 files changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
>> index 31054e3..f1f6700 100644
>> --- a/drivers/spi/spi-imx.c
>> +++ b/drivers/spi/spi-imx.c
>> @@ -68,17 +68,6 @@ enum spi_imx_devtype {
>>        IMX51_ECSPI,    /* ECSPI on i.mx51 and later */
>>  };
>>
>> -struct spi_imx_data;
>> -
>> -struct spi_imx_devtype_data {
>> -       void (*intctrl)(struct spi_imx_data *, int);
>> -       int (*config)(struct spi_imx_data *, struct spi_imx_config *);
>> -       void (*trigger)(struct spi_imx_data *);
>> -       int (*rx_available)(struct spi_imx_data *);
>> -       void (*reset)(struct spi_imx_data *);
>> -       enum spi_imx_devtype devtype;
>> -};
> 
> Is this change intentional

Yes, struct spi_imx_data must be defined prior to spi_imx_devtype_data.

Thanks,

Fabio Estevam


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
