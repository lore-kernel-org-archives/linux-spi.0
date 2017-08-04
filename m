From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH RFC 1/2] spi: pxa2xx: Convert to GPIO descriptor API where
 possible
Date: Fri, 4 Aug 2017 12:18:28 +0200
Message-ID: <b411858d-6a09-a3bc-555d-b1e648b9c8ed@siemens.com>
References: <cover.1501760433.git.jan.kiszka@siemens.com>
 <6bfd2b29b888c14f1a6feb9dee5bb54b74e761b0.1501760433.git.jan.kiszka@siemens.com>
 <20170804101029.GV2369@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi <linux-spi@vger.kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170804101029.GV2369@lahna.fi.intel.com>
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

On 2017-08-04 12:10, Mika Westerberg wrote:
> On Thu, Aug 03, 2017 at 01:40:32PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> We still need to request/free GPIOs passed via the legacy path of
>> pxa2xx_spi_chip::gpio_cs, but we can use the gpiod API otherwise.
>>
>> Consistently use the descriptor API instead of the legacy one.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> There are some PXA2xx platforms under arch/arm/* which use this driver
> and legacy GPIOs. I wonder if this causes any problems with them?
> 
> That was one of the reasons I did not convert the whole driver over GPIO
> descriptors.

It shouldn't cause problems (famous last words) because I refrained from
changing the interfaces to them. References that come in as legacy GPIO
are still treated like that.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
