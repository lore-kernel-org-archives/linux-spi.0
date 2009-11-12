From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
 <richard.rojfors@mocean-labs.com>
Subject: Re: [PATCH v2 1/4] xilinx_spi: Split into of driver and generic part.
Date: Thu, 12 Nov 2009 18:22:40 +0100
Message-ID: <4AFC4460.9050508@mocean-labs.com>
References: <4AFC1B1E.60304@mocean-labs.com>
	<fa686aa40911120656x3b94b9c7tfabd6e7956ed41fb@mail.gmail.com>
	<38eacaec-f0d3-436c-b461-40b5d795cdd9@VA3EHSMHS009.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	dbrownell@users.sourceforge.net, linuxppc-dev@ozlabs.org
To: John Linn <John.Linn@xilinx.com>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <38eacaec-f0d3-436c-b461-40b5d795cdd9@VA3EHSMHS009.ehs.local>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

On 11/12/09 6:17 PM, John Linn wrote:
>> Have you compile tested this?  platform_data is a void*, the
>> dereference will not work.  I know you don't have hardware; but
>> getting the needed cross compiler is easy.
> 
> Here's the fixes I did to make it compile. On to testing :)

Great! I tested this against a max7301 GPIO expander.

--Richard
