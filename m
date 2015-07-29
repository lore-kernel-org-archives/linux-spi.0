From: Michal Suchanek <hramrach@gmail.com>
Subject: [RFC PATCH 0/2] disambiguate s3c64xx controller-data and ofpart
 partition nodes
Date: Wed, 29 Jul 2015 13:14:44 +0200
Message-ID: <cover.1438168484.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Mark Brown <broonie@kernel.org>, Michal Suchanek <hramrach@gmail.com>,
 Padmavathi Venna <padma.kvr@gmail.com>,
 Boris BREZILLON <boris.brezillon@free-electrons.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

Hello,

the ofpart partition nodes and s3c64xx controller-data nodes are both subnodes
of MTD SPI slaves such as spi-nor.

When ofpart is compiled-in and no partitions are defined on a MTD SPI slave
ofpart tries to parse the controller-data node, gets confused, mtd probe fails,
and the mtd device is inaccessible.

ofpart claims all subnodes of mtd devices which have no compatible and when
there is a subnode but no partitions are found it reports error which is then
propagated to mtd probe.

A simple fix that turns the error into a warning was rejected on the basis that
the ofpart parser could then accept invalid devicetree as fallback.

https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg941351.html

Firstly, the ofpart parser already does accept 'invalid' trees as fallback.
Looking at the code it only requires that there is one mtd subnode that parses
as partition and there can be arbitrary number of other nodes which were not
understood. It only singles out the case when there are subnodes but none is
understood as partition.

Secondly, the fact that a devicetree node is not understood by a particular
driver does not make it 'invalid'.

In my view either it is acceptable that nodes without compatible property exist
and then drivers using such nodes should be ready to gracefully handle nodes
that do not have compatible property but are meant for another driver. The
s3c64xx driver already does this but ofpart does not.

On the other hand, if not using a compatible property is not acceptable then
both drivers should use a compatible property to reserve their subnodes for
themselves and avoid any conflict.

Either way I would like the maintainers of the conflicting drivers to agree on
where compatible property should be and where not so that compiling-in ofpart
does not make valid MTD devices inaccessible.

The patches are only for illustration and are not meant to be included
anywhere. They are not tested and miss adding the properties to tens of binding
docs and dts files.

Thanks

Michal

Michal Suchanek (2):
  dt: mtd: ofpart: use compatible for partitions
  dt: spi: s3c64xx: add compatible to controller-data

 .../devicetree/bindings/mtd/partition.txt          |  7 +++++-
 .../devicetree/bindings/spi/spi-samsung.txt        |  3 +++
 drivers/mtd/ofpart.c                               | 26 +++++++++++++---------
 drivers/spi/spi-s3c64xx.c                          |  4 ++++
 4 files changed, 29 insertions(+), 11 deletions(-)

-- 
2.1.4
