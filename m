From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH 1/2] spi: stm32-qspi: add spi_master_put in release
 function
Date: Mon, 25 Mar 2019 17:19:44 +0100
Message-ID: <7742cae8-3fcf-a3ba-2807-d5ed100cd8a4@st.com>
References: <1553265354-16433-1-git-send-email-ludovic.Barre@st.com>
 <1553265354-16433-2-git-send-email-ludovic.Barre@st.com>
 <20190325160313.GJ7284@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325160313.GJ7284@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

hi Mark

On 3/25/19 5:03 PM, Mark Brown wrote:
> On Fri, Mar 22, 2019 at 03:35:53PM +0100, Ludovic Barre wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch adds spi_master_put in release function
>> to drop the controller's refcount.
> 
> I'm getting build errors with this:
> 
>    CC      drivers/spi/spi-stm32-qspi.o
> drivers/spi/spi-stm32-qspi.c: In function ‘stm32_qspi_probe’:
> drivers/spi/spi-stm32-qspi.c:430:8: error: ‘struct stm32_qspi’ has no member named ‘phys_base’; did you mean ‘io_base’?
>    qspi->phys_base = res->start;
>          ^~~~~~~~~
>          io_base
> 

I was sure I built each patch, but the fact is there an error :-(
I resend a serie with this line in the second patch

Regards
Ludo
