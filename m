From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH] enc28j60: Fix sporadic packet loss
	(correction)
Date: Tue, 2 Dec 2008 10:59:47 +0200
Message-ID: <20081202085947.GB24490@diamond.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Shachar Shemesh <shachar-bEkjeIDUMOLQT0dZR+AlfA@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Claudio Lanconelli <lanconelli.claudio-DtroZxfa9uMAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Packet data read from the RX buffer the when the RSV is at the end of the RX 
buffer does not warp around. This causes packet loss, as the actual data is 
never read. Fix this by calculating the right packet data location.

Thanks to Shachar Shemesh for suggesting the fix.

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>

---

The previous patch didn't increase the read pointer when no warp around was 
needed. This is corrected here.


--- drivers/net/enc28j60.c-git	2008-12-02 09:08:24.000000000 +0200
+++ drivers/net/enc28j60.c	2008-12-02 09:38:33.000000000 +0200
@@ -568,6 +568,17 @@ static u16 erxrdpt_workaround(u16 next_p
 	return erxrdpt;
 }
 
+/*
+ * Calculate wrap around when reading beyond the end of the RX buffer
+ */
+static u16 rx_packet_start(u16 ptr)
+{
+	if (ptr + RSV_SIZE > RXEND_INIT)
+		return (ptr + RSV_SIZE) - RXEND_INIT - 1;
+	else
+		return ptr + RSV_SIZE;
+}
+
 static void nolock_rxfifo_init(struct enc28j60_net *priv, u16 start, u16 end)
 {
 	u16 erxrdpt;
@@ -938,8 +949,9 @@ static void enc28j60_hw_rx(struct net_de
 			skb->dev = ndev;
 			skb_reserve(skb, NET_IP_ALIGN);
 			/* copy the packet from the receive buffer */
-			enc28j60_mem_read(priv, priv->next_pk_ptr + sizeof(rsv),
-					len, skb_put(skb, len));
+			enc28j60_mem_read(priv,
+				rx_packet_start(priv->next_pk_ptr),
+				len, skb_put(skb, len));
 			if (netif_msg_pktdata(priv))
 				dump_packet(__func__, skb->len, skb->data);
 			skb->protocol = eth_type_trans(skb, ndev);

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
