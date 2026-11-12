Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452009;
	b=RbnhmtzDONaUdCxquct3ubykY2xsx/udIG05l8pnHv3PUKJLssQq6tb49Hd+F79bzkcM
	 OuJ4l33GqEVZoA3vLEgp4IZszZGEcn48JtesFjqHdAh7cx+bNpqybBmSB6urVkrWQ8kiM
	 5L7lbowWQvfc0opZuY467zBlzGqegcmTt1wd0hRPTVlrJLJqQbtXUnxAr39vNdeWi6FaY
	 ktje0+1yHE0LgU+7U9Gow2y63xRrhuvEmTncYtzjmEP+ToPv5PK+a9eM2HLy1lhkmdvVh
	 owKSJgjyrSav5ZV3etO8ruMunQFPHN6oAlFY7X+Ij1deg/WBDwkQqjOE2f6RvGdkyGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Nc4XLNPToEMaydN4Y5LPmHECaS4FBVXGXKRGT4Pu6v8=;
	b=pV/Sc5QTWmMsdGQYDkttASR5w0G+SlXexYdORR3l4PfSnXLfQkXgDsLMH8o9OFpHHSoZ
	 jke3f6LfufggvVBS+ftDyGDjnhpJB/x3Tb2zyuIBrBKjMZES6KrHbvptWh7yRqbnjs5AO
	 6ccpAHvfRQ8jq4jjWkElKGzkIckoKGJ5fxRog1bkY6yxVLFNOVv+h/YkDFo4U6+OJwUoO
	 DidrLUtZp4q8FinWcHPv2jFm50T1FCX2w0OSTe+JsWq77bGy8gkB6Z4IFSl9WZ8IfmZjZ
	 SG7ldCNH4S0h7KQriyQy6JrpQipjVe0AmSNN3L/wMRBJyQXJTaPrPMMWxW0tN2khG3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ausil.us;
	spf=pass smtp.mailfrom=ausil.us;
	dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256 header.s=google header.b=akEjgfZW;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14A1606A323
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 02:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D14A1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ausil.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ausil.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256 header.s=google header.b=akEjgfZW
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so2602350a91.3
        for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2026 18:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ausil.us; s=google; t=1794452008; x=1795056808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nc4XLNPToEMaydN4Y5LPmHECaS4FBVXGXKRGT4Pu6v8=;
        b=akEjgfZW2c9l/EHMTj/y8UJnf+VdnqxXROFLwwnOpgzYiaNGygiB1U1QeTFjG6S2Xo
         wpcBhe3O0zcUjSOBL1aRk7UhVwVaDEqLifEJmjCtDYAlbZXSxKUSouFA6gTXOxaHP/8Y
         22sbMMh5kr4mw2em4P75pXVFJx9MiFfXqZOlSCX/qD/aJWinzPygNUnLg7daruJADX2p
         WEa2vGDwelccNRzRpDe79u7EIsn88utl2Q0je09uBSB5ykH1Q9uj82S6TO5JVK7yCWiP
         2qD1lR7HrgJ+7D22rqNT10s5vr0/O5aiveqgPC3VSnxOHai4yEtQ+Q0SryW3R/LwM/Df
         DD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794452008; x=1795056808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nc4XLNPToEMaydN4Y5LPmHECaS4FBVXGXKRGT4Pu6v8=;
        b=VqQxKwI7n4d0yskvSmIZeJPGO4nx9QsQ+ALSfaFtMmOzkQqZvW9jgvO280tT48BdPv
         +9HOLYfB06tO0l387JM/tBnfbgAEUaimcUETPzMvRNnXHxmxYzENnG4oHQd2UN3QqKy+
         HqCIJYTuXnuzF8R1ufR7hTqPOG9i3k4G4XzBmPostF/YP5APDcnwsio8XvS3Qs2npV+2
         qFkLm42h+Tti/LNNy1/IKJEr++xMHHK9ajWIv33ZVzIMy2mnBGBLrtX3hlv3brDnGl7Z
         GFWOJPlu30Hj4rncYcm2RpPIszuyHZFJmlvYW3rmEZQMZjlacfgTOLgvW/EWuNuixLNd
         J+cw==
X-Forwarded-Encrypted: i=1; AL+hErH7xjkt7MHjNDqnBlxLa+7tIwXgJ9YIj0dr2nKbNWS5c2B/NwgohO26ywO4PuBIsnNpBoo/QK9hBw0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/a/gviex/vqc26eJJNgzSTM9AF03YLQnOIXFdHjIIF7WXqDKg3
	wrLDDPAXhd3B0xpeYaENjsQAAKsQEooiizPhdC2V9FexJ47m3wVe5GaXKpByi5L58GRb44iM5IJ
	EVPhHYSqYeLzvSP6FZpgvM8dAu9hWNsUYMMgq
X-Gm-Gg: AYBFou2sgvKo0Py0x7UB3XmtD669k9HN1IOOKAocKWQPRkdjaLLR9jpzXpWK+MVQWYA
	H1bTSkQFti0Lx24+LGSqO0xgNxG+byJHjohN4aNmVM6HEJOFJrblkLTgQTMssfDzwsWAX27+TWn
	aOain2Q+qBtA3A/4uZ1UBHk0d0Sl0haHpLYnG5Erj7PoMkUlbMzQoy68nAoMjpzBPp3ZEyJc/F/
	JIgjvfiXanDGNsC3gXIDydw0nA/CvtFKFOKPf3wm5lFayXo75kHoYwzg8Brg31zY3KXkOj9mCEj
	iXb3Vw96bXUx0HOJiBnG8Oxd9e9Tfdmff1cD4UiigrAzTlMNhVmZ/4HexwmaDh8ZXPV+JgcS4qH
	nEogKhFNWju1POtSpWPZXaA4=
X-Received: by 2002:a17:90b:590f:b0:3ab:2c2b:1026 with SMTP id 98e67ed59e1d1-3b182eec413mr4274267a91.34.1794452007867;
        Wed, 11 Nov 2026 18:53:27 -0800 (PST)
Received: from thor.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b181c053cdsm1542175a91.0.2026.11.11.18.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 18:53:27 -0800 (PST)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: broonie@kernel.org,
	lgirdwood@gmail.com
Cc: perex@perex.cz,
	tiwai@suse.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-sound@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	linux-spi@vger.kernel.org,
	miriam.rachel.korenblit@intel.com,
	linux-wireless@vger.kernel.org,
	Dennis Gilmore <dennis@ausil.us>
Subject: [PATCH] ASoC: soc-core: start rtd->num_components at zero
Date: Wed, 11 Nov 2026 20:52:51 -0600
Message-ID: <20261112025252.71375-1-dennis@ausil.us>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the conversion to devm_kzalloc_flex(), the allocator sets the
__counted_by() counter num_components to the allocated length
(num_cpus + num_codecs + num_platforms). This only happens when the
compiler supports __builtin_counted_by_ref() (GCC 16 here). With
older compilers the counter stays zero, as before.

snd_soc_rtd_add_component() treats num_components as the number of
components added so far: it increments the counter and stores the
new component at num_components - 1. Starting from the preset
length, every component is written past the end of the allocation.
On a link with one CPU, one codec and one platform, entries 3 to 5
of a 3-entry array are written, and components[0] stays NULL.

for_each_rtd_components() stops at that NULL entry, so
soc_probe_link_components() probes no component, and
component->card stays NULL for every component on the card. The
first DAI .probe callback that uses its component's card then
dereferences NULL. On an HP OmniBook X 14 (MediaTek MT8901
SoundWire with CS42L43 and CS35L56 codecs) binding the card
crashes in cs42l43_dai_probe():

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000038
  Internal error: Oops: 0000000096000004 [#1]  SMP
  pc : snd_soc_card_get_kcontrol+0x18/0x40 [snd_soc_core]
  lr : snd_soc_component_get_kcontrol+0x6c/0xc0 [snd_soc_core]
  Call trace:
   snd_soc_card_get_kcontrol+0x18/0x40 [snd_soc_core] (P)
   snd_soc_component_get_kcontrol+0x6c/0xc0 [snd_soc_core]
   cs42l43_dai_probe+0xb0/0x148 [snd_soc_cs42l43]
   snd_soc_pcm_dai_probe+0x70/0xf8 [snd_soc_core]
   snd_soc_bind_card+0x4d4/0x8c0 [snd_soc_core]
   call_soc_bind_card+0x70/0xf0 [snd_soc_core]
   snd_soc_register_card+0xd8/0x110 [snd_soc_core]
   devm_snd_soc_register_card+0x20/0x38 [snd_soc_core]
   mt8901_card_probe+0x258/0x5c8 [mt8901_acp_sdw_legacy_mach]
   platform_probe+0x88/0xc0

Reset the counter after allocation, so components are added from
index 0 again as they were before the conversion.

The bug was found, and this fix written, with the help of an AI
coding assistant (Claude). Tested on the HP OmniBook X 14: the card
binds and playback and capture work.

Fixes: 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the devm_kmalloc_obj() family")
Signed-off-by: Dennis Gilmore <dennis@ausil.us>
---
An alternative fix would be to keep num_components as the array size
and have snd_soc_rtd_add_component() fill the first NULL slot. The
counter would still need to be set explicitly, because the preset does
not happen on compilers without __builtin_counted_by_ref(). Resetting it
keeps the original design and the tighter __counted_by() bounds.

Kees, the same pattern (a *_flex() allocation followed by code that uses
the counter as a fill index starting from zero) looks to be present in
two places converted by 69050f8d6d07 ("treewide: Replace kmalloc with
kmalloc_obj for non-scalar types"). I have only read the code for these.
I have no hardware for either and have not reproduced them, so please
treat them as possible issues rather than confirmed bugs:

 - drivers/spi/spi-axi-spi-engine.c: spi_engine_optimize_message()
   allocates p with kzalloc_flex(*p, instructions, p_dry.length + 1),
   which presets p->length, and spi_engine_compile_message() then
   appends with p->length++ through spi_engine_program_add_cmd().

 - drivers/net/wireless/intel/iwlwifi/mld/d3.c:
   iwl_mld_process_netdetect_res() allocates netdetect_info with
   kzalloc_flex(..., matches, n_matches), presetting n_matches, and
   iwl_mld_set_netdetect_info() stores at matches[n_matches] and then
   increments it. The per-match kzalloc_flex(..., channels, n_channels)
   has the same issue with match->n_channels.

If they are real, the fix would be the same as here. I'm happy to send
patches. It may also be worth a Coccinelle check for this pattern.

 sound/soc/soc-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 68b54e509b65..e4d911577c5f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -388,6 +388,13 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
 		return NULL;
 	}
 
+	/*
+	 * devm_kzalloc_flex() presets the __counted_by() counter to the
+	 * allocated size, but snd_soc_rtd_add_component() uses
+	 * num_components as the number of components added so far.
+	 */
+	rtd->num_components = 0;
+
 	rtd->dev = dev;
 	INIT_LIST_HEAD(&rtd->list);
 	for_each_pcm_streams(stream) {
-- 
2.56.0

