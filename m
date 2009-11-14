From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC] MAINTAINERS: add SPI co-maintainer.
Date: Fri, 13 Nov 2009 17:25:45 -0700
Message-ID: <20091114001001.5343.99566.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org, dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757732AbZKNAZp@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Hi David, Andrew.

David, I know that you haven't had enough time lately to keep on top
of the pending SPI patches, so I was wondering if you would like some
help?  If you are interested, I'm willing to act as co-maintainer of
for the SPI subsystem.

Here's what I'm thinking.  Right now all SPI patches are going through
the -mm tree and just adding to akpm's burden.  I'd be more than happy
to take over the task of actually collecting the acked patches into a
git tree, getting them some exposure on linux-next, and asking Linus
to pull it during the merge window.  If you ack them, then I'll merge
them.

I'm also be willing to take responsibility for all powerpc-specific
SPI patches so that you don't need to look at them.

How does this sound to you?

Cheers,
g.

 MAINTAINERS |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a1a2ace..2b697cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4937,6 +4937,7 @@ F:	drivers/char/specialix*
 
 SPI SUBSYSTEM
 M:	David Brownell <dbrownell@users.sourceforge.net>
+M:	Grant Likely <grant.likely@secretlab.ca>
 L:	spi-devel-general@lists.sourceforge.net
 S:	Maintained
 F:	Documentation/spi/
