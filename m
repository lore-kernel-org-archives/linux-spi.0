From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v8 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Wed, 5 Feb 2020 09:38:11 +0530
Message-ID: <9fc3e36d-18c2-c5fb-2fed-7ffcef817692@ti.com>
References: <20200129072455.35807-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200129072455.35807-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qszwQ5sJw4G_fM5vKjYu24xs03CuW371gyFE4G0hNJHdXw@mail.gmail.com>
 <abaae0fa-c2b8-bbe0-b64d-0ee4c95c1479@linux.intel.com>
 <CAAh8qsxRPx8KDyqvp=8zcrGCE82YJ_9O9cJXrgKdH7VwXeGQgg@mail.gmail.com>
 <0f079cf6-c146-8941-5bdd-f978ff3455ab@linux.intel.com>
 <d938fcc6-3e9b-2b5d-bf6c-1de7c8649798@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <dan.carpenter@oracle.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
        "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
        Tien-Fong Chee <tien.fong.chee@intel.com>,
        Marek Vasut <marex@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d938fcc6-3e9b-2b5d-bf6c-1de7c8649798@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Dinh,

On 04/02/20 9:27 pm, Dinh Nguyen wrote:
[...]
>>>> Already I checked that Graham Moore <grmoore@opensource.altera.com>
>>>> who has submitted the existing driver patches to upstream,
>>>> His mail-id is bouncing back, then I decided that you are the right
>>>> person to ask, could you please add them in loop if you know the team
>>>> (socfpga platform engineers).
> 
> Thanks for including Graham, but he's moved on to a different career
> that no longer includes Linux.
> 
>>> OK, done that. I mainly know them from U-Boot development, so I'm not
>>> sure
>>> who's responsible for the Linux drivers...
>> Thank you for adding the team and respective members, let's see.
>>
> 
> I don't have the original patch series, but will monitor going forward.
> As long as the new driver does not break legacy SoCFPGA products that
> use the cadence-quadspi driver then it should be ok.
> 

The legacy driver under drivers/mtd/spi-nor will be removed as we cannot
support both SPI NOR and SPI NAND with single driver if its under
spi-nor. New driver should be functionally equivalent to existing one.
So I suggest you test this driver on legcay SoCFPGA products.


-- 
Regards
Vignesh
