From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 0/5] Make SPI work on DT MMP2
Date: Mon, 10 Sep 2018 13:59:30 +0200
Message-ID: <20180910115935.163121-1-lkundrak@v3.sk>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Bjorn Helgaas <bhelgaas@google.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This makes SPI work on an OPLC 1.75 that is a DT MMP2 platform.
