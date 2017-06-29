From: Amelie DELAUNAY <amelie.delaunay@st.com>
Subject: Re: [PATCHv2 9/9] spi: spidev: add Aardvark to device tree
 compatibility list
Date: Thu, 29 Jun 2017 14:58:43 +0200
Message-ID: <67764839-889b-e398-16eb-de583d82cbf3@st.com>
References: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
 <1498578321-13980-10-git-send-email-amelie.delaunay@st.com>
 <20170628185445.fsnqs2tlqqeqzl57@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170628185445.fsnqs2tlqqeqzl57@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org



On 06/28/2017 08:54 PM, Mark Brown wrote:
> On Tue, Jun 27, 2017 at 05:45:21PM +0200, Amelie Delaunay wrote:
>> This patch adds an entry for the TotalPhase Aardvark SPI Host Adapter,
>> which can operate as an SPI Slave.
> 
> What does this device actually do and why is spidev a sensible fit for
> it?
> 
This device is actually a debugging tool [1] which can work on SPI bus 
(and also I2C). Connected via USB on a PC, it can either acts as an SPI 
master or SPI slave and it can transmit/receive serial data using SPI 
protocol. Polarity, Phase, Bit Order, Frequency can be configured. So 
this tool is really useful during SPI driver development to 
troubleshoot. And that's why spidev driver totally fit for it when used 
as an SPI slave, for the reason described in spidev Documentation: 
"Developing simple protocols used to talk to" Aardvark "acting as SPI 
slaves, which you may need to change quite often".

[1] https://www.totalphase.com/products/aardvark-i2cspi/
