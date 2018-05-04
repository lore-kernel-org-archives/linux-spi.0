From: Yixun Lan <yixun.lan@amlogic.com>
Subject: Re: [PATCH 3/3] spi: meson-axg: add a linear clock divider support
Date: Fri, 4 May 2018 10:07:12 +0800
Message-ID: <e5610b7f-9e34-3925-cb40-1c62a3c470d2@amlogic.com>
References: <20180503213645.20694-1-yixun.lan@amlogic.com>
 <20180503213645.20694-4-yixun.lan@amlogic.com>
 <20180503231604.GD13402@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, yixun.lan@amlogic.com,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Sunny Luo <sunny.luo@amlogic.com>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180503231604.GD13402@sirena.org.uk>
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

Hi Mark

On 05/04/18 07:16, Mark Brown wrote:
> On Thu, May 03, 2018 at 09:36:44PM +0000, Yixun Lan wrote:
>> From: Sunny Luo <sunny.luo@amlogic.com>
>>
>> The SPICC controller in Meson-AXG SoC is capable of using
>> a linear clock divider to reach a much fine tuned range of clocks,
>> while the old controller only use a power of two clock divider,
>> result at a more coarse clock range.
>>
>> Also convert the clock registeration into Common Clock Framework.
> 
> This would be better split into two patches - one adding the new linear
> clock divider and the other one doing the CCF conversion.  Splitting
> things out like that makes them much easier to review as each change is
> only doing one thing.
> 

it's maybe obscure in my previous commit message, the clock divider
support is actually achieved via CCF framework, it can be split as two
independent patches..

I'm CCing clock mailing list (will do if I need to send a v2)

Yixun
