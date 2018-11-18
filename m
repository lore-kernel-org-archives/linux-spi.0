From: Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/1] npcm: fix uninitialized 'val' warning in receive function
Date: Sun, 18 Nov 2018 14:35:03 +0200
Message-ID: <20181118123504.83082-1-tmaimon77@gmail.com>
Cc: linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Addressed comments from:.
 - kbuild test robot : drivers/spi/spi-npcm-pspi.c:226:17: warning:
  'val' may be used uninitialized in this function.
  
Fix uninitialized 'val' warning receive function.
Send function has been modify to be aligned with 
the receive function.

The NPCM PSPI driver tested on NPCM750 evaluation board.

Tomer Maimon (1):
  spi: npcm: fix uninitialized 'val' warning in receive function

 drivers/spi/spi-npcm-pspi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.14.1
