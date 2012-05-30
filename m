From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 02/10] spi: s3c64xx: move controller information into
 driver data
Date: Wed, 30 May 2012 16:00:15 +0800
Message-ID: <CAJuYYwRn5R-qm7kv8D8pf6dfinNkDOdgJpMhqgsH2vVF-J9vUw@mail.gmail.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
	<1336514694-22393-3-git-send-email-thomas.abraham@linaro.org>
	<CAOesGMjGfCH1T6WXPzMDLKsD=URdm15G1SDM=ac624KLmSS=4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, kgene.kim@samsung.com,
	jaswinder.singh@linaro.org
To: Olof Johansson <olof@lixom.net>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAOesGMjGfCH1T6WXPzMDLKsD=URdm15G1SDM=ac624KLmSS=4w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Olof,

On 30 May 2012 15:23, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> Some comments below.
>
> On Tue, May 8, 2012 at 3:04 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>> Platform data is used to specify controller hardware specific inform=
ation
>> such as the tx/rx fifo level mask and bit offset of rx fifo level. S=
uch
>> information is not suitable to be supplied from device tree. Instead=
,
>> it can be moved into the driver data and removed from platform data.
>>
>> Cc: Jaswinder Singh <jaswinder.singh@linaro.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> =A0drivers/spi/spi-s3c64xx.c | =A0180 ++++++++++++++++++++++++++++++=
++++++++-------
>> =A01 files changed, 153 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 6a3d51a..f6bc0e3 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>
>> @@ -171,6 +198,8 @@ struct s3c64xx_spi_driver_data {
>> =A0 =A0 =A0 =A0struct s3c64xx_spi_dma_data =A0 =A0 rx_dma;
>> =A0 =A0 =A0 =A0struct s3c64xx_spi_dma_data =A0 =A0 tx_dma;
>> =A0 =A0 =A0 =A0struct samsung_dma_ops =A0 =A0 =A0 =A0 =A0*ops;
>> + =A0 =A0 =A0 struct s3c64xx_spi_port_config =A0*port_conf;
>> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
port_id;
>
> unsigned int

Ok.

>
>
>> @@ -942,6 +964,13 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_s=
pi_driver_data *sdd, int channel)
>> =A0 =A0 =A0 =A0flush_fifo(sdd);
>> =A0}
>>
>> +static inline struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_=
config(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 struct platform_device *pdev)
>> +{
>> + =A0 =A0 =A0 return (struct s3c64xx_spi_port_config *)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0platform_get_device=
_id(pdev)->driver_data;
>> +}
>> +
>> =A0static int __init s3c64xx_spi_probe(struct platform_device *pdev)
>> =A0{
>> =A0 =A0 =A0 =A0struct resource *mem_res, *dmatx_res, *dmarx_res;
>> @@ -1000,6 +1029,7 @@ static int __init s3c64xx_spi_probe(struct pla=
tform_device *pdev)
>> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, master);
>>
>> =A0 =A0 =A0 =A0sdd =3D spi_master_get_devdata(master);
>> + =A0 =A0 =A0 sdd->port_conf =3D s3c64xx_spi_get_port_config(pdev);
>> =A0 =A0 =A0 =A0sdd->master =3D master;
>> =A0 =A0 =A0 =A0sdd->cntrlr_info =3D sci;
>> =A0 =A0 =A0 =A0sdd->pdev =3D pdev;
>
> Single-use helper? Might as well open code it in this case.

This helper function 's3c64xx_spi_get_port_config' is populated with
more code later in the 'add spi support' patch. Which simplifies the
code flow here. So I prefer to maintain this as a separate function.

>
>
>> @@ -1227,6 +1258,100 @@ static const struct dev_pm_ops s3c64xx_spi_p=
m =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c64xx_spi_runt=
ime_resume, NULL)
>> =A0};
>>
>> +#if defined(CONFIG_CPU_S3C2416) || defined(CONFIG_CPU_S3C2443)
>> +struct s3c64xx_spi_port_config s3c2443_spi_port_config =3D {
>> + =A0 =A0 =A0 .fifo_lvl_mask =A0=3D { 0x7f },
>> + =A0 =A0 =A0 .rx_lvl_offset =A0=3D 13,
>> + =A0 =A0 =A0 .tx_st_done =A0 =A0 =3D 21,
>> + =A0 =A0 =A0 .high_speed =A0 =A0 =3D true,
>> +};
>> +#define S3C2443_SPI_PORT_CONFIG ((kernel_ulong_t)&s3c2443_spi_port_=
config)
>> +#else
>> +#define S3C2443_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
>> +#endif
>
> Is it really worth it to do the ifdefs here for just 16 bytes of data
> per entry? The table itself below takes more space.

Ok. The ifdefs do reduce the readability of this code. So I will leave
the ifdefs in this patch.

>
>
> [..]
>
>> +#ifdef CONFIG_ARCH_S5PV210
>> +struct s3c64xx_spi_port_config s5pv210_spi_port_config =3D {
>> + =A0 =A0 =A0 .fifo_lvl_mask =A0=3D { 0x1ff, 0x7F },
>> + =A0 =A0 =A0 .rx_lvl_offset =A0=3D 15,
>> + =A0 =A0 =A0 .tx_st_done =A0 =A0 =3D 25,
>> + =A0 =A0 =A0 .high_speed =A0 =A0 =3D 1,
>
> high_speed =3D true
>
>> +};
>> +#define S5PV210_SPI_PORT_CONFIG ((kernel_ulong_t)&s5pv210_spi_port_=
config)
>> +#else
>> +#define S5PV210_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
>> +#endif /* CONFIG_ARCH_S5PV210 */
>> +
>> +#ifdef CONFIG_ARCH_EXYNOS4
>> +struct s3c64xx_spi_port_config exynos4_spi_port_config =3D {
>> + =A0 =A0 =A0 .fifo_lvl_mask =A0=3D { 0x1ff, 0x7F, 0x7F },
>> + =A0 =A0 =A0 .rx_lvl_offset =A0=3D 15,
>> + =A0 =A0 =A0 .tx_st_done =A0 =A0 =3D 25,
>> + =A0 =A0 =A0 .high_speed =A0 =A0 =3D 1,
>
> high_speed =3D true

Ok.

Thanks for your comments.

Regards,
Thomas.

>
>
>
> -Olof
