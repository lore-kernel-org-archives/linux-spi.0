From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
Subject: [PATCH 0/4] xilinx_spi: Split into platform and of driver, support
	new IP, platform independence.
Date: Wed, 11 Nov 2009 15:37:10 +0100
Message-ID: <4AFACC16.8030808@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	dbrownell@users.sourceforge.net, John Linn <John.Linn@xilinx.com>
To: spi-devel-general@lists.sourceforge.net
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
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

Hi,

To follow is a series of patches against the xilinx_spi driver.

The patchset is against 2.6.32-rc6

The patchset addresses several problems in the current driver:
* It's PPC only (OF and uses PPC specific memory operations)
* Only supporting big endian writes
* Supports only 8bit SPI, support for DS570 (also 16 or 32 bit) is added.
* A platform driver is introduced for non OF capable architectures.

These patches were posted as one big patch up to 4 iterations, not splitted into 4.

--Richard
