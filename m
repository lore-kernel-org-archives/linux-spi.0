From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH V2 0/4] mtd: spi-nor: add a new framework for SPI NOR
Date: Thu, 12 Dec 2013 10:52:20 +0530
Message-ID: <52A9480C.6020002@ti.com>
References: <1386318764-15882-1-git-send-email-b32955@freescale.com>
 <52A881CF.4020001@ti.com> <20131212041425.GA1460@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: marex@denx.de, angus.clark@st.com, broonie@linaro.org, lee.jones@linaro.org,
 linux-spi@vger.kernel.org, Huang Shijie <b32955@freescale.com>,
 linux-mtd@lists.infradead.org, pekon@ti.com, computersforpeace@gmail.com,
 dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
To: Huang Shijie <shijie8@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131212041425.GA1460@gmail.com>
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

On Thursday 12 December 2013 09:44 AM, Huang Shijie wrote:
> On Wed, Dec 11, 2013 at 08:46:31PM +0530, Sourav Poddar wrote:
>> As you see in my patches, once we take care of the above points and
>> add support
>> for memory mapped in m25p80 and qspi, then while doing a read in
>> m25p80 we can
>> do memcpy at the beginning of m25p80_read and can bypass the entire SPI
>> framework for memory mapped read operation. Throughput almost gets
>> doubles with this,
>> as compared to normal SPI operations.
>>
>> So, my intention of reviving this here is to add one more feature
>> set, which I suppose
>> spi nor framework should handle and to see what needs to be added
>> more for this feature.
> I already read your patch.
>

> My quadspi driver also uses the memory map mode.
> The memory map mode is the default mode for the quadspi driver's read.
>
>
> You can setup the registers for memory map in the probe() or some other
> places.  And use the spi_nor->read() hook to do the memcpy in your driver.
>
So, setting these registers should be set in my qspi controller driver 
in spi layer.
There registers requires flash opcodes and other flash specific 
parameters. I dont intend
to get this from dt, so need this information to be send via the mtd 
layer. So, dont think if
the present hooks will help me out.

Secondly, I had a dependency on few registers to switch between memory 
mapped mode and
spi mode. So, even though read is by default memory mapped, I need to 
write to qspi register
to switch to memory mapped mode and once the read is done, switch the 
controller back to
SPI mode.

So all in all, some hooks like
   - configure_master_from_slave
   - enable_mmap/disable_mmap is desired.

Do you think, we can handle/integrate this case in the above framework?
> thanks
> Huang Shijie
>
