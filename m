From: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v10 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Tue, 25 Feb 2020 09:53:12 +0530
Message-ID: <99f7e23f-268d-f32b-086f-4a46fc232ce9@ti.com>
References: <20200219022852.28065-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <simon.k.r.goldschmidt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        <dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <tien.fong.chee-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, <marex-ynQEQJNshbs@public.gmane.org>,
        <cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, <qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200219022852.28065-1-vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On 19/02/20 7:58 am, Ramuthevar,Vadivel MuruganX wrote:
[...]
>     CHECK   Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dt.yaml
> 
> Ramuthevar Vadivel Murugan (2):
>   dt-bindings: spi: Add schema for Cadence QSPI Controller driver
>   spi: cadence-quadpsi: Add support for the Cadence QSPI controller
> 
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 147 +++++
>  drivers/mtd/spi-nor/Kconfig                        |  11 -
>  drivers/mtd/spi-nor/Makefile                       |   1 -
>  drivers/spi/Kconfig                                |   8 +
>  drivers/spi/Makefile                               |   1 +
>  .../spi-cadence-quadspi.c}                         | 641 ++++++++++-----------
>  6 files changed, 459 insertions(+), 350 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml

You will have to remove old bindings as well. Also please CC linux-mtd
list as these patches touch drivers/mtd/*

Just run scripts/get_maintainer.pl on your patches to get list of
mailing list and people to CC

>  rename drivers/{mtd/spi-nor/cadence-quadspi.c => spi/spi-cadence-quadspi.c} (73%)
> 

-- 
Regards
Vignesh
