From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 02/11] PCI: Provide pci_match_id() with CONFIG_PCI=n
Date: Wed, 10 Oct 2018 19:09:27 +0200
Message-ID: <20181010170936.316862-3-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: James Cameron <quozl@laptop.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010170936.316862-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This spares drivers from #ifdef-ing on CONFIG_PCI if the driver can be
optionally built on machines without PCI bus.

Consistent with acpi_driver_match_device() and similar.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Capitalization in the commit message

 include/linux/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6925828f9f25..2c4755032475 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1705,6 +1705,10 @@ static inline int pci_irqd_intx_xlate(struct irq_d=
omain *d,
 				      unsigned long *out_hwirq,
 				      unsigned int *out_type)
 { return -EINVAL; }
+
+static inline const struct pci_device_id *pci_match_id(const struct pci_=
device_id *ids,
+							 struct pci_dev *dev)
+{ return NULL; }
 #endif /* CONFIG_PCI */
=20
 /* Include architecture-dependent settings and functions */
--=20
2.19.0
