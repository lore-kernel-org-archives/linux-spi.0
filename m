From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: [PATCH v2 4/4] spi: spi-fsl-dspi: Fix adjust the byte order when sending and receiving data
Date: Sun, 30 Sep 2018 12:27:24 +0200
Message-ID: <87k1n3701f.fsf@gmail.com>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930092535.24544-4-chuanhua.han@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com
To: Chuanhua Han <chuanhua.han@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930092535.24544-4-chuanhua.han@nxp.com> (Chuanhua Han's
        message of "Sun, 30 Sep 2018 17:25:35 +0800")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Chuanhua Han <chuanhua.han@nxp.com> writes:

> This patch fixes the byte order inversion problem in the XSPI mode of
> the dspi controller during data transfer.
> In XSPI mode,When I read and write data without converting the byte
> order of the data, and read and write the data directly, I tested spi
> flash connected by the dspi controller and found that the byte
> order of the data was reversed by the correct byte order.
> When I changed the byte order according to the SPIx_CTARn[LSBFE] flag,
> the correct data was obtained.

I believe this is related to patch 1/4 of this series, and your attempt
on pushing the 8-bit spi-mem data into 32-bit SPI words.  The
byte-ordering for that does not belong here, and will likely break
byte-ordering for other (proper) use of XSPI mode.

My advice is that you focus your effort on implementing/fixing DMA mode,
ie. erratum A-011218.
A proper implementation of that will be appreciated, and should give you
much better performance than XSPI mode would be able to give you.

/Esben
